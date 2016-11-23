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

local onHyperlinkLeave = function (self)
    hooks[self].OnHyperlinkLeave(self);

    _G.GameTooltip:Hide();
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    hooks:RegisterScript(chatFrame, "OnHyperlinkEnter", onHyperlinkEnter);
    hooks:RegisterScript(chatFrame, "OnHyperlinkLeave", onHyperlinkLeave);
end);