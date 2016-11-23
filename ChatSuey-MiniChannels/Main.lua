local ChatTypes = _G.ChatTypeInfo;
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local LS = ChatSuey.Locales[_G.GetLocale()].Strings;

local MINI_CHANNELS = {
    [ChatTypes.PARTY.id] = { alias = LS["P"] },
    [ChatTypes.PARTY_LEADER.id] = { alias = LS["PL"] },
    [ChatTypes.RAID.id] = { alias = LS["R"] },
    [ChatTypes.GUILD.id] = { alias = LS["G"] },
    [ChatTypes.INSTANCE_CHAT.id] = { alias = LS["I"] },
    [ChatTypes.INSTANCE_CHAT_LEADER.id] = { alias = LS["IL"] },
    [ChatTypes.OFFICER.id] = { alias = LS["O"] },
    [ChatTypes.RAID_LEADER.id] = { alias = LS["RL"] },
    [ChatTypes.RAID_WARNING.id] = { alias = LS["RW"] },
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

-- E.g., "|Hchannel:GUILD|h[Guild]|h"
local CHANNEL_HEADER_FORMAT = "|H(channel:[^|]-)|h[^|]-|h";

-- E.g., "|Hplayer:Chatsuey|h[Chatsuey]|h says:"
-- Battle.net whispers use "|HBN" instead of just "|H"
local ROLEPLAY_HEADER_FORMAT = "^(.-|HB?N?player:[^%s]+) %l+";

local CHANNEL_PATH_FORMAT = "^[cC][hH][aA][nN][nN][eE][lL]:(%d+)$";

-- Don't want to minimize channel headers in change/join/leave
-- notifications, so we'll check the beginning of messages to
-- make sure they don't start the same as those notifications.
-- All notifications are in a similar format to:
-- "Changed Channel: |Hchannel:%d|h[%s]|h"
-- We just want the localized text before the channel link.
local CHANGED_CHANNEL_TEXT = _G.CHAT_YOU_CHANGED_NOTICE:match("^[^|]+");
local JOINED_CHANNEL_TEXT = _G.CHAT_YOU_JOINED_NOTICE:match("^[^|]+");
local LEFT_CHANNEL_TEXT = _G.CHAT_YOU_LEFT_NOTICE:match("^[^|]+");

local isRoleplayMessage = function (messageId)
    return messageId == ChatTypes.SAY.id
        or messageId == ChatTypes.YELL.id
        or messageId == ChatTypes.WHISPER.id
        or messageId == ChatTypes.BN_WHISPER.id;
end;

local addMessage = function (self, text, red, green, blue, messageId, holdTime)
    local channel = MINI_CHANNELS[messageId];

    if channel
        and text:find(CHANGED_CHANNEL_TEXT) ~= 1
        and text:find(JOINED_CHANNEL_TEXT) ~= 1
        and text:find(LEFT_CHANNEL_TEXT) ~= 1
    then
        text = text:gsub(CHANNEL_HEADER_FORMAT, function (uri)
            return ChatSuey.Hyperlink(uri, channel.alias);
        end);
    end

    if isRoleplayMessage(messageId) then
        text = text:gsub(ROLEPLAY_HEADER_FORMAT, "%1");
    end

    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

local onHyperlinkEnter = function (self, uri, link)
    hooks[self].OnHyperlinkEnter(self, uri, link);

    local scheme, path, text = ChatSuey.HyperlinkComponents(link);

    if scheme ~= ChatSuey.UriSchemes.CHANNEL then
        return;
    end

    local channel = path:match(CHANNEL_PATH_FORMAT);
    if not channel then
        return;
    end

    local messageId = ChatTypes["CHANNEL" .. channel].id;
    if text ~= MINI_CHANNELS[messageId].alias then
        return;
    end

    local _, channelName = _G.GetChannelName(channel);
    if not channelName then
        return;
    end

    local tooltip = ("%d. %s"):format(channel, channelName)

    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, _G.UIParent);
    _G.GameTooltip:SetText(tooltip);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function (self)
    hooks[self].OnHyperlinkLeave(self);

    _G.GameTooltip:Hide();
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
end);