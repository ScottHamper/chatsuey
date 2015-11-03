local _G = getfenv();
local ChatSuey = _G.ChatSuey;
ChatSuey.Timestamps = ChatSuey.Timestamps or {};
ChatSuey.Timestamps.Config = {};

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

local hexColorByteToNum = function (hexByte)
    return tonumber(hexByte, 16) / 255;
end;

local r = function (self)
    local rHex = string.sub(self.color, 1, 2);
    return hexColorByteToNum(rHex);
end;

local g = function (self)
    local gHex = string.sub(self.color, 3, 4);
    return hexColorByteToNum(gHex);
end;

local b = function (self)
    local bHex = string.sub(self.color, 5, 6);
    return hexColorByteToNum(bHex);
end;

setmetatable(ChatSuey.Timestamps.Config, {
    __mode = "k",
    __index = function (self, key)
        local config = {
            use24HourClock = defaults.use24HourClock,
            includeSeconds = defaults.includeSeconds,
            useConsistentColor = defaults.useConsistentColor,
            color = defaults.color,
            r = r,
            g = g,
            b = b,
        };

        self[key] = config;
        return config;
    end,
});