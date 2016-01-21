local ChatSuey = _G.ChatSuey;

local LocaleTable = {
    DEFAULT = ChatSuey.Locale:new(),
};

setmetatable(LocaleTable, {
    __index = function (self, key)
        return self.DEFAULT;
    end,
});

function LocaleTable:new(defaultLocale)
    local localeTable = {
        DEFAULT = defaultLocale,
    };

    setmetatable(localeTable, {
        __index = self,
    });

    return localeTable;
end

ChatSuey.LocaleTable = LocaleTable;