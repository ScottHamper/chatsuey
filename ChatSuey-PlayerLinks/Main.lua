local ChatSuey = _G.ChatSuey;
local hooks = ChatSuey.HookTable:new();

local onHyperlinkClick = function (self, uri, ...)
    local scheme, path = ChatSuey.UriComponents(uri);

    if scheme == ChatSuey.UriSchemes.PLAYER and _G.IsAltKeyDown() then
        local player = path:match("^[^:]+");

        _G.InviteUnit(player);
        return;
    end

    hooks[self].OnHyperlinkClick(self, uri, ...);
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end);