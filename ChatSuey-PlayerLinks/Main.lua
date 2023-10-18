local ChatSuey = _G.ChatSuey;

local onHyperlinkClick = function (self, uri, ...)
    local scheme, path = ChatSuey.UriComponents(uri);
    
    if scheme == ChatSuey.UriSchemes.PLAYER and _G.IsAltKeyDown() then
        local player = path:match("^[^:]+");

        -- Since `onHyperlinkClick` is a post-hook, we can't prevent the default behavior of
        -- the chat edit box opening when a player link is clicked, so we will force the box to
        -- immediately close by calling `OnEscapePressed`.
        _G.ChatEdit_OnEscapePressed(self.editBox);

        _G.C_PartyInfo.InviteUnit(player);
        return;
    end
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    chatFrame:HookScript("OnHyperlinkClick", onHyperlinkClick);
end);
