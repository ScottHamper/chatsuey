local _G = getfenv();
local ChatSuey = _G.ChatSuey;
ChatSuey.DB.Config = ChatSuey.DB.Config or {};
ChatSuey.DB.Config.Timestamps = ChatSuey.DB.Config.Timestamps or {};

local defaults = {
    use24HourClock = true,
    includeSeconds = false,
    useConsistentColor = false,
    color = ChatSuey.Colors.WHITE,
};

for i = 1, _G.NUM_CHAT_WINDOWS do
    local chatFrameName = "ChatFrame" .. i;
    local configs = ChatSuey.DB.Config.Timestamps;
    configs[chatFrameName] = configs[chatFrameName] or {};

    setmetatable(configs[chatFrameName], {
        __index = function (self, key)
            self[key] = defaults[key];
            return defaults[key];
        end,
    });
end