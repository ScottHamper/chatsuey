local ChatSuey = _G.ChatSuey;

ChatSuey.SetFont = function (chatFrame)
    local config = ChatSuey.DB.Config.Font[chatFrame:GetName()];
    local _, size, _ = chatFrame:GetFont();

    chatFrame:SetFont(config.path, size, config.outline);
end;

ChatSuey.OnChatFrameReady(function (chatFrame)
    ChatSuey.SetFont(chatFrame);
end);