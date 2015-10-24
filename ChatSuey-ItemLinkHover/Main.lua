local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local isItemUri = function (uri)
    local _, _, scheme = string.find(uri, "([^:]-):");
    return scheme == "item";
end;

local onHyperlinkEnter = function ()
    local uri = _G.arg1;
    local link = _G.arg2;

    hooks[this].OnHyperlinkEnter(this, uri, link);

    if not isItemUri(uri) then
        return;
    end

    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, UIParent);
    _G.GameTooltip:SetHyperlink(uri);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function ()
    local uri = _G.arg1;
    local link = _G.arg2;

    hooks[this].OnHyperlinkLeave(this, uri, link);

    if not isItemUri(uri) then
        return;
    end

    _G.GameTooltip:Hide();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
end