local _G = getfenv();
local ChatSuey = _G.ChatSuey;
ChatSuey.DB.Config = ChatSuey.DB.Config or {};
ChatSuey.DB.Config.Font = ChatSuey.DB.Config.Font or {};

local defaults = {
    outline = nil,
    family = "Arial Narrow",
};

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrameName = "ChatFrame" .. i;
    local configs = ChatSuey.DB.Config.Font;
    configs[chatFrameName] = configs[chatFrameName] or {};

    setmetatable(configs[chatFrameName], {
        __index = function (self, key)
            self[key] = defaults[key];
            return defaults[key];
        end,
    });
end