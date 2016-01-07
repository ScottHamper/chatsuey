local _G = getfenv();
local ChatTypes = _G.ChatTypeInfo;
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local LS = ChatSuey.Locales[_G.GetLocale()].Strings;

local MINI_CHANNELS = {
    [ChatTypes.PARTY.id] = { alias = LS["P"] },
    [ChatTypes.RAID.id] = { alias = LS["R"] },
    [ChatTypes.GUILD.id] = { alias = LS["G"] },
    [ChatTypes.OFFICER.id] = { alias = LS["O"] },
    [ChatTypes.RAID_LEADER.id] = { alias = LS["RL"] },
    [ChatTypes.RAID_WARNING.id] = { alias = LS["RW"] },
    [ChatTypes.BATTLEGROUND.id] = { alias = LS["BG"] },
    [ChatTypes.BATTLEGROUND_LEADER.id] = { alias = LS["BL"] },
    [ChatTypes.CHANNEL1.id] = { alias = "1", number = 1 },
    [ChatTypes.CHANNEL2.id] = { alias = "2", number = 2 },
    [ChatTypes.CHANNEL3.id] = { alias = "3", number = 3 },
    [ChatTypes.CHANNEL4.id] = { alias = "4", number = 4 },
    [ChatTypes.CHANNEL5.id] = { alias = "5", number = 5 },
    [ChatTypes.CHANNEL6.id] = { alias = "6", number = 6 },
    [ChatTypes.CHANNEL7.id] = { alias = "7", number = 7 },
    [ChatTypes.CHANNEL8.id] = { alias = "8", number = 8 },
    [ChatTypes.CHANNEL9.id] = { alias = "9", number = 9 },
    [ChatTypes.CHANNEL10.id] = { alias = "10", number = 10 },
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
    local channel = MINI_CHANNELS[messageId];

    if channel then
        local header = string.format("[%s] ", channel.alias);
        text = string.gsub(text, CHANNEL_HEADER_FORMAT, header);
    end

    if isRoleplayMessage(messageId) then
        text = string.gsub(text, ROLEPLAY_HEADER_FORMAT, "%1");
    end

    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

local onHyperlinkEnter = function ()
    hooks[this].OnHyperlinkEnter();

    local uri = _G.arg1;
    local scheme, path = ChatSuey.UriComponents(uri);

    if scheme ~= ChatSuey.UriSchemes.CHANNEL then
        return;
    end

    local messageId = tonumber(path);
    local channel = MINI_CHANNELS[messageId];

    if not (channel and channel.number) then
        return;
    end

    local _, channelName = _G.GetChannelName(channel.number);
    local tooltip = string.format("%d. %s", channel.number, channelName)

    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, _G.UIParent);
    _G.GameTooltip:SetText(tooltip);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function ()
    hooks[this].OnHyperlinkLeave();

    local uri = _G.arg1;
    local scheme = ChatSuey.UriComponents(uri);

    if scheme ~= ChatSuey.UriSchemes.CHANNEL then
        return;
    end

    _G.GameTooltip:Hide();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
end