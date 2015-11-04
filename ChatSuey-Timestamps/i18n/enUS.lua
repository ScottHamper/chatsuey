local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local enUS = ChatSuey.Locale:new();
local LS = enUS.Strings;

ChatSuey.Timestamps.LOCALES = ChatSuey.Timestamps.LOCALES or ChatSuey.LocaleTable:new(enUS);
ChatSuey.Timestamps.LOCALES["enUS"] = enUS;

-- The following is unnecessary, but it serves as a good reference for
-- how to implement a locale, as well as being a list of all the
-- localized strings used.

LS["Timestamps"] = "Timestamps";
LS["Use 24 hour clock"] = "Use 24 hour clock";
LS["Include seconds"] = "Include seconds";
LS["Use consistent color"] = "Use consistent color";