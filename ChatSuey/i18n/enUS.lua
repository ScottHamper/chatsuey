local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local enUS = ChatSuey.Locale:new();
local LS = enUS.Strings;

ChatSuey.LOCALES["enUS"] = enUS;
ChatSuey.LOCALES.DEFAULT = enUS;

-- The following is unnecessary, but it serves as a good reference for
-- how to implement a locale, as well as being a list of all the
-- localized strings used.

-- CSS2 Colors
LS["BLACK"] = "BLACK";
LS["GRAY"] = "GRAY";
LS["SILVER"] = "SILVER";
LS["WHITE"] = "WHITE";
LS["PURPLE"] = "PURPLE";
LS["MAROON"] = "MAROON";
LS["RED"] = "RED";
LS["FUCHSIA"] = "FUCHSIA";
LS["GREEN"] = "GREEN";
LS["LIME"] = "LIME";
LS["OLIVE"] = "OLIVE";
LS["YELLOW"] = "YELLOW";
LS["NAVY"] = "NAVY";
LS["BLUE"] = "BLUE";
LS["TEAL"] = "TEAL";
LS["AQUA"] = "AQUA";
LS["ORANGE"] = "ORANGE";

-- WoW Item Quality Colors
LS["POOR"] = "POOR";
LS["COMMON"] = "COMMON";
LS["UNCOMMON"] = "UNCOMMON";
LS["RARE"] = "RARE";
LS["EPIC"] = "EPIC";
LS["LEGENDARY"] = "LEGENDARY";
LS["ARTIFACT"] = "ARTIFACT";
LS["HEIRLOOM"] = "HEIRLOOM";
LS["TOKEN"] = "TOKEN";
LS["BLIZZARD"] = "BLIZZARD";

-- Other WoW Colors
LS["SPELL"] = "SPELL";
LS["SKILL"] = "SKILL";
LS["TALENT"] = "TALENT";