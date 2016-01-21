local ChatSuey = _G.ChatSuey;

local Locale = {
    Strings = {},
};

setmetatable(Locale.Strings, {
    __index = function (self, str)
        return str;
    end,
});

function Locale:new()
    local locale = {};

    setmetatable(locale, {
        __index = self,
    });

    return locale;
end

ChatSuey.Locale = Locale;