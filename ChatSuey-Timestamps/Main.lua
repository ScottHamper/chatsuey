local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local PLAYER_MESSAGE_TYPES = {
    [_G.ChatTypeInfo["SAY"].id] = true,
    [_G.ChatTypeInfo["PARTY"].id] = true,
    [_G.ChatTypeInfo["RAID"].id] = true,
    [_G.ChatTypeInfo["GUILD"].id] = true,
    [_G.ChatTypeInfo["OFFICER"].id] = true,
    [_G.ChatTypeInfo["YELL"].id] = true,
    [_G.ChatTypeInfo["WHISPER"].id] = true,
    [_G.ChatTypeInfo["RAID_LEADER"].id] = true,
    [_G.ChatTypeInfo["RAID_WARNING"].id] = true,
    [_G.ChatTypeInfo["BATTLEGROUND"].id] = true,
    [_G.ChatTypeInfo["BATTLEGROUND_LEADER"].id] = true,
    [_G.ChatTypeInfo["CHANNEL1"].id] = true,
    [_G.ChatTypeInfo["CHANNEL2"].id] = true,
    [_G.ChatTypeInfo["CHANNEL3"].id] = true,
    [_G.ChatTypeInfo["CHANNEL4"].id] = true,
    [_G.ChatTypeInfo["CHANNEL5"].id] = true,
    [_G.ChatTypeInfo["CHANNEL6"].id] = true,
    [_G.ChatTypeInfo["CHANNEL7"].id] = true,
    [_G.ChatTypeInfo["CHANNEL8"].id] = true,
    [_G.ChatTypeInfo["CHANNEL9"].id] = true,
    [_G.ChatTypeInfo["CHANNEL10"].id] = true,
};

-- TODO: Allow configuring in-game
local config = {
    utcFormat = "%H:%M:%S UTC",
    localFormat = "%H:%M",
    alwaysDisplay = false,
    color = nil,
};

local addMessage = function (self, text, red, green, blue, messageId, holdTime)
    if not (config.alwaysDisplay or PLAYER_MESSAGE_TYPES[messageId]) then
        hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
        return;
    end

    local now = time();
    local utcTime = date("!" .. config.utcFormat, now);
    local localTime = date(config.localFormat, now);

    local timestamp = ChatSuey.Hyperlink("time:" .. utcTime, localTime, config.color);

    text = timestamp .. " " .. text;
    hooks[self].AddMessage(self, text, red, green, blue, messageId, holdTime);
end;

local isTimeUri = function (uri)
    local scheme, _ = ChatSuey.UriComponents(uri);
    return scheme == "time";
end;

local onHyperlinkEnter = function ()
    local uri = _G.arg1;
    local link = _G.arg2;

    hooks[this].OnHyperlinkEnter(this, uri, link);

    if not isTimeUri(uri) then
        return;
    end

    local _, utcTime = ChatSuey.UriComponents(uri);
    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, UIParent);
    _G.GameTooltip:SetText(utcTime);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function ()
    local uri = _G.arg1;
    local link = _G.arg2;

    hooks[this].OnHyperlinkEnter(this, uri, link);

    if not isTimeUri(uri) then
        return;
    end

    _G.GameTooltip:Hide();
end;

local onHyperlinkClick = function ()
    local uri = _G.arg1;
    local link = _G.arg2;
    local button = _G.arg3;

    -- NoOp to prevent an "Unknown link type" error
    if isTimeUri(uri) then
        return;
    end

    hooks[this].OnHyperlinkClick(this, uri, link, button);
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];

    hooks:RegisterFunc(chatFrame, "AddMessage", addMessage);
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end