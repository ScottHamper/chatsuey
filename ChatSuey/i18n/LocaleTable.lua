local _G = getfenv();
local ChatSuey = _G.ChatSuey;

local LocaleTable = {};

function LocaleTable:new(defaultLocale)
    local localeTable = {
        DEFAULT = defaultLocale,
    };

    setmetatable(localeTable, {
        __index = function (self, key)
            return self.DEFAULT;
        end,
    });

    return localeTable;
end

ChatSuey.LocaleTable = LocaleTable;