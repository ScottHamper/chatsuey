local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local MENTION_EVENTS = {
    CHAT_MSG_SAY = true,
    CHAT_MSG_EMOTE = true,
    CHAT_MSG_TEXT_EMOTE = true,
    CHAT_MSG_YELL = true,
    CHAT_MSG_PARTY = true,
    CHAT_MSG_PARTY_LEADER = true,
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
    CHAT_MSG_MONSTER_PARTY = true,
    CHAT_MSG_RAID_BOSS_EMOTE = true,
    CHAT_MSG_CHANNEL = true,
};

local PLAYER_NAME = _G.UnitName("player");

-- We want case-insensitive player name matches, and Lua doesn't give
-- us a built-in way to do it.
local PLAYER_PATTERN = PLAYER_NAME:gsub("%a", function (letter)
    return ("[%s%s]"):format(letter:lower(), letter:upper());
end);

-- Undocumented "frontier" pattern allows us to match the player
-- name as an isolated word, while also matching the name at the
-- beginning or end of a message.
local HIGHLIGHT_PATTERN = "%f[%a](" .. PLAYER_PATTERN .. ")%f[%A]";

local HIGHLIGHT_COLOR = ChatSuey.Colors.WHITE;

local highlight = function (text)
    return ("|c%s%s|r"):format(HIGHLIGHT_COLOR, text);
end;

local onEvent = function (self, event, message, sender, ...)
    if not MENTION_EVENTS[event] or sender == PLAYER_NAME then
        hooks[self].OnEvent(self, event, message, sender, ...);
        return;
    end

    local message, count = message:gsub(HIGHLIGHT_PATTERN, highlight);

    if count > 0 then
        _G.PlaySound("TellMessage", "SFX");
    end

    hooks[self].OnEvent(self, event, message, sender, ...);
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    hooks:RegisterScript(chatFrame, "OnEvent", onEvent);
end);