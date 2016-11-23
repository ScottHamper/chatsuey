local ChatSuey = _G.ChatSuey;

local Locale = {};

function Locale:new()
    local locale = {
        Strings = {},
    };

    setmetatable(locale.Strings, {
        __index = function (self, str)
            return str;
        end,
    });

    return locale;
end

ChatSuey.Locale = Locale;