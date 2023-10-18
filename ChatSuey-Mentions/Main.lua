local ChatSuey = _G.ChatSuey;

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

local filter = function (self, event, message, sender, ...)
    if sender == PLAYER_NAME then
        return false, message, sender, ...;
    end

    local message, count = message:gsub(HIGHLIGHT_PATTERN, highlight);

    if count > 0 then
        _G.PlaySound(_G.SOUNDKIT.TELL_MESSAGE);
    end

    return false, message, sender, ...;
end;

for event, _ in pairs(MENTION_EVENTS) do
    _G.ChatFrame_AddMessageEventFilter(event, filter);
end
