local _G = getfenv();
local ChatTypes = _G.ChatTypeInfo;
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local LS = ChatSuey.Locales[_G.GetLocale()].Strings;

local ABBREVIATIONS = {
    [ChatTypes.PARTY.id] = LS["P"],
    [ChatTypes.RAID.id] = LS["R"],
    [ChatTypes.GUILD.id] = LS["G"],
    [ChatTypes.OFFICER.id] = LS["O"],
    [ChatTypes.RAID_LEADER.id] = LS["RL"],
    [ChatTypes.RAID_WARNING.id] = LS["RW"],
    [ChatTypes.BATTLEGROUND.id] = LS["BG"],
    [ChatTypes.BATTLEGROUND_LEADER.id] = LS["BL"],
    [ChatTypes.CHANNEL1.id] = "1",
    [ChatTypes.CHANNEL2.id] = "2",
    [ChatTypes.CHANNEL3.id] = "3",
    [ChatTypes.CHANNEL4.id] = "4",
    [ChatTypes.CHANNEL5.id] = "5",
    [ChatTypes.CHANNEL6.id] = "6",
    [ChatTypes.CHANNEL7.id] = "7",
    [ChatTypes.CHANNEL8.id] = "8",
    [ChatTypes.CHANNEL9.id] = "9",
    [ChatTypes.CHANNEL10.id] = "10",
};

-- E.g., "[1. General] [Chatsuey]:"
local CHANNEL_HEADER_FORMAT = "^%[[^%]]-%] ";

-- E.g., "[Chatsuey] says:"
-- "|Hplayer:Chatsuey|h[Chatsuey]|h says:"
local ROLEPLAY_HEADER_FORMAT = "^([^%s]+) %l+";

local isRoleplayMessage = function (messageId)
    return messageId == ChatTypes.SAY.id
        or messageId == ChatTypes.YELL.id
        or messageId == ChatTypes.WHISPER.id;
end;

local addMessage = function (self, text, red, green, blue, messageId, holdTime)
    local abbreviation = ABBREVIATIONS[messageId];

    if abbreviation then
        local header = string.format("[%s] ", abbreviation);
        text = string.gsub(text, CHANNEL_HEADER_FORMAT, header);
    end

    if isRoleplayMessage(messageId) then
        text = string.gsub(text, ROLEPLAY_HEADER_FORMAT, "%1");
    end

    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
end