local _G = getfenv();
local ChatSuey = _G.ChatSuey;
ChatSuey.DB.Config = ChatSuey.DB.Config or {};
ChatSuey.DB.Config.Timestamps = ChatSuey.DB.Config.Timestamps or {};

local defaults = {
    use24HourClock = true,
    includeSeconds = false,
    useConsistentColor = false,
    color = ChatSuey.COLORS.WHITE,
};

setmetatable(ChatSuey.DB.Config.Timestamps, {
    __index = function (self, key)
        local config = {
            use24HourClock = defaults.use24HourClock,
            includeSeconds = defaults.includeSeconds,
            useConsistentColor = defaults.useConsistentColor,
            color = defaults.color,
        };

        self[key] = config;
        return config;
    end,
});