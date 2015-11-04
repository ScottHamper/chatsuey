local _G = getfenv();
local ChatSuey = _G.ChatSuey;
ChatSuey.DB.Config = ChatSuey.DB.Config or {};
ChatSuey.DB.Config.Timestamps = ChatSuey.DB.Config.Timestamps or {};

-- TODO: Persist settings per account
local defaults = {
    use24HourClock = true,
    includeSeconds = false,
    useConsistentColor = false,
    color = "ffffff",

    -- Possible Enhancement: Display for:
    -- All messages
    -- Player messages
    -- Combat messages
    -- System messages
    -- Emotes
    -- Loot messages
    -- Skill messages
};

setmetatable(ChatSuey.DB.Config.Timestamps, {
    __mode = "k",
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