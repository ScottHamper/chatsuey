local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local MENTION_EVENTS = {
    CHAT_MSG_SAY = true,
    CHAT_MSG_EMOTE = true,
    CHAT_MSG_TEXT_EMOTE = true,
    CHAT_MSG_YELL = true,
    CHAT_MSG_PARTY = true,
    CHAT_MSG_RAID = true,
    CHAT_MSG_RAID_LEADER = true,
    CHAT_MSG_RAID_WARNING = true,
    CHAT_MSG_BATTLEGROUND = true,
    CHAT_MSG_BATTLEGROUND_LEADER = true,
    CHAT_MSG_GUILD = true,
    CHAT_MSG_OFFICER = true,
    GUILD_MOTD = true,
    CHAT_MSG_MONSTER_SAY = true,
    CHAT_MSG_MONSTER_YELL = true,
    CHAT_MSG_MONSTER_EMOTE = true,
    CHAT_MSG_RAID_BOSS_EMOTE = true,
    CHAT_MSG_CHANNEL = true,
};

local PLAYER_NAME = _G.UnitName("player");

-- We want case-insensitive player name matches, and Lua doesn't give
-- us a built-in way to do it.
local PLAYER_PATTERN = string.gsub(PLAYER_NAME, "%a", function (letter)
    local lowercase = string.lower(letter);
    local uppercase = string.upper(letter);

    return string.format("[%s%s]", lowercase, uppercase);
end);

-- Undocumented "frontier" pattern allows us to match the player
-- name as an isolated word, while also matching the name at the
-- beginning or end of a message.
local HIGHLIGHT_PATTERN = "%f[%a](" .. PLAYER_PATTERN .. ")%f[%A]";
local HIGHLIGHT_PATTERN_PREFIXED = "(%S*)" .. HIGHLIGHT_PATTERN;

local HIGHLIGHT_COLOR = ChatSuey.Colors.WHITE;

local COLORED_LINK_PATTERN = "|c(.-)|H(.-)|h(.-)|h|r";

local highlight = function (text)
    return string.format("|c%s%s|r", HIGHLIGHT_COLOR, text);
end;

local replaceMentions = function (message)
    local foundMention = false;

    -- Color tags do not nest, so we have to end/restart a link's color
    -- before/after highlighting a player name inside of it.
    message = string.gsub(message, COLORED_LINK_PATTERN, function (color, uri, text)
        -- The `count` return value from this `gsub` call would indicate whether
        -- a mention has been found, but we can't return it through the outer
        -- `gsub` call. Thus we use a closure on `foundMention`.
        text = string.gsub(text, HIGHLIGHT_PATTERN, function (name)
            foundMention = true;
            return string.format("|r%s|c%s", highlight(name), color);
        end);

        return string.format("|c%s|H%s|h%s|h|r", color, uri, text);
    end);

    message = string.gsub(message, HIGHLIGHT_PATTERN_PREFIXED, function (prefix, name)
        -- We want to ignore the player name if it's part of a link URI
        -- or if it's already been highlighted (only relevant if the
        -- `HIGHLIGHT_COLOR` ends in a non-letter, as the call to `gsub`
        -- will not find a match otherwise).
        local ignore = string.sub(prefix, -9) == "|Hplayer:"
            or string.sub(prefix, -10) == "|c" .. HIGHLIGHT_COLOR;

        if ignore then
            return prefix .. name;
        end

        -- Can't rely on `count` return value from `gsub` call since the match
        -- could be ignored, so we rely on a closure around `foundMention` again.
        foundMention = true;
        return prefix .. highlight(name);
    end);

    return message, foundMention;
end;

local onEvent = function ()
    if not MENTION_EVENTS[_G.event] then
        hooks[this].OnEvent();
        return;
    end

    local message = _G.arg1;
    local sender = _G.arg2;

    if sender == PLAYER_NAME then
        hooks[this].OnEvent();
        return;
    end

    local message, foundMention = replaceMentions(message);

    if foundMention then
        _G.PlaySound("TellMessage", "SFX");
    end

    _G.arg1 = message;
    hooks[this].OnEvent();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnEvent", onEvent);
end