local _G = getfenv();
local ChatSuey = _G.ChatSuey;

ChatSuey.SetFont = function (chatFrame)
    local config = ChatSuey.DB.Config.Font[chatFrame:GetName()];
    local _, size, _ = chatFrame:GetFont();

    chatFrame:SetFont(ChatSuey.FONTS[config.family], size, config.outline);
end;

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    ChatSuey.SetFont(chatFrame);
end