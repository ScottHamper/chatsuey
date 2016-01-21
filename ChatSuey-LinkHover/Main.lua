local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();
local schemes = ChatSuey.UriSchemes;

local TOOLTIP_SCHEMES = {
    [schemes.ACHIEVEMENT] = true,
    [schemes.ENCHANT] = true,
    [schemes.GLYPH] = true,
    [schemes.ITEM] = true,
    [schemes.QUEST] = true,
    [schemes.SPELL] = true,
    [schemes.TALENT] = true,
};

local onHyperlinkEnter = function (self, uri, link)
    hooks[self].OnHyperlinkEnter(self, uri, link);

    local scheme = ChatSuey.UriComponents(uri);

    if not TOOLTIP_SCHEMES[scheme] then
        return;
    end

    _G.GameTooltip_SetDefaultAnchor(_G.GameTooltip, _G.UIParent);
    _G.GameTooltip:SetHyperlink(uri);
    _G.GameTooltip:Show();
end;

local onHyperlinkLeave = function (self, uri, link)
    hooks[self].OnHyperlinkLeave(self, uri, link);

    local scheme = ChatSuey.UriComponents(uri);

    if not TOOLTIP_SCHEMES[scheme] then
        return;
    end

    _G.GameTooltip:Hide();
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
end

-- Tooltips get stuck open when scrolling the chat window.
hooks:RegisterFunc(_G, "FloatingChatFrame_OnMouseScroll", function (self, delta)
    hooks[_G].FloatingChatFrame_OnMouseScroll(self, delta);
    _G.GameTooltip:Hide();
end);