local _G = getfenv();
local ChatTypes = _G.ChatTypeInfo;
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local HEADER_FORMAT = "^%[([^%]]-)%]";

local LINKED_CHANNELS = {
    [ChatTypes.PARTY.id] = { type = "PARTY" },
    [ChatTypes.RAID.id] = { type = "RAID" },
    [ChatTypes.GUILD.id] = { type = "GUILD" },
    [ChatTypes.OFFICER.id] = { type = "OFFICER" },
    [ChatTypes.RAID_LEADER.id] = { type = "RAID" },
    [ChatTypes.RAID_WARNING.id] = { type = "RAID" },
    [ChatTypes.BATTLEGROUND.id] = { type = "BATTLEGROUND" },
    [ChatTypes.BATTLEGROUND_LEADER.id] = { type = "BATTLEGROUND" },
    [ChatTypes.CHANNEL1.id] = { type = "CHANNEL", target = 1 },
    [ChatTypes.CHANNEL2.id] = { type = "CHANNEL", target = 2 },
    [ChatTypes.CHANNEL3.id] = { type = "CHANNEL", target = 3 },
    [ChatTypes.CHANNEL4.id] = { type = "CHANNEL", target = 4 },
    [ChatTypes.CHANNEL5.id] = { type = "CHANNEL", target = 5 },
    [ChatTypes.CHANNEL6.id] = { type = "CHANNEL", target = 6 },
    [ChatTypes.CHANNEL7.id] = { type = "CHANNEL", target = 7 },
    [ChatTypes.CHANNEL8.id] = { type = "CHANNEL", target = 8 },
    [ChatTypes.CHANNEL9.id] = { type = "CHANNEL", target = 9 },
    [ChatTypes.CHANNEL10.id] = { type = "CHANNEL", target = 10 },
};

local addMessage = function (self, text, red, green, blue, messageId, holdTime)
    if LINKED_CHANNELS[messageId] then
        text = string.gsub(text, HEADER_FORMAT, function (header)
            local uri = ChatSuey.Uri(ChatSuey.UriSchemes.CHANNEL, messageId);
            return ChatSuey.Hyperlink(uri, header);
        end);
    end

    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

local onHyperlinkClick = function ()
    local uri = _G.arg1;
    local scheme, path = ChatSuey.UriComponents(uri);

    if scheme ~= ChatSuey.UriSchemes.CHANNEL then
        hooks[this].OnHyperlinkClick();
        return;
    end

    local messageId = tonumber(path);
    local channel = LINKED_CHANNELS[messageId];

    _G.ChatFrameEditBox.chatType = channel.type;
    _G.ChatFrameEditBox.channelTarget = channel.target;
    _G.ChatFrameEditBox:Show();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end