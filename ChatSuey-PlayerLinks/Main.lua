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

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrame = _G["ChatFrame" .. i];
    hooks:RegisterScript(chatFrame, "OnHyperlinkClick", onHyperlinkClick);
end