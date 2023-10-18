local ChatSuey = _G.ChatSuey;
ChatSuey.DB.Config = ChatSuey.DB.Config or {};
ChatSuey.DB.Config.Font = ChatSuey.DB.Config.Font or {};

local defaults = {
    outline = "",
    path = ChatSuey.Fonts.ARIAL_NARROW.path,
};

ChatSuey.OnChatFrameReady(function (chatFrame)
    local name = chatFrame:GetName();
    local configs = ChatSuey.DB.Config.Font;
    configs[name] = configs[name] or {};

    setmetatable(configs[name], {
        __index = function (self, key)
            self[key] = defaults[key];
            return defaults[key];
        end,
    });
end);