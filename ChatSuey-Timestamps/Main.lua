local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local UTC_FULL_FORMAT = "!%H:%M:%S UTC";

local addMessage = function (self, text, red, green, blue, messageId, holdTime)
    local config = ChatSuey.DB.Config.Timestamps[self:GetName()];

    local localFormat = string.format("%s:%%M%s%s",
        config.use24HourClock and "%H" or "%I",
        config.includeSeconds and ":%S" or "",
        config.use24HourClock and "" or " %p");

    local now = time();
    local utcTime = date(UTC_FULL_FORMAT, now);
    local localTime = date(localFormat, now);
    local color = config.useConsistentColor and config.color or nil;

    local uri = ChatSuey.Uri(ChatSuey.UriSchemes.TIME, utcTime);
    local timestamp = ChatSuey.Hyperlink(uri, localTime, color);

    text = timestamp .. " " .. text;
    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

local onHyperlinkEnter = function ()
    hooks[this].OnHyperlinkEnter();

    local uri = _G.arg1;
    local scheme, utcTime = ChatSuey.UriComponents(uri);

    if scheme ~= ChatSuey.UriSchemes.TIME then
        return;
    end

    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, UIParent);
    _G.GameTooltip:SetText(utcTime);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function ()
    hooks[this].OnHyperlinkLeave();

    local uri = _G.arg1;
    local scheme = ChatSuey.UriComponents(uri);

    if scheme ~= ChatSuey.UriSchemes.TIME then
        return;
    end

    _G.GameTooltip:Hide();
end;

local onHyperlinkClick = function ()
    local uri = _G.arg1;
    local scheme = ChatSuey.UriComponents(uri);

    -- NoOp to prevent an "Unknown link type" error
    if scheme == ChatSuey.UriSchemes.TIME then
        return;
    end

    hooks[this].OnHyperlinkClick();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end