local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local zhCN = ChatSuey.Locale:new();
local LS = zhCN.Strings;

ChatSuey.Locales = ChatSuey.Locales or ChatSuey.LocaleTable:new(zhCN);
ChatSuey.Locales["zhCN"] = zhCN;

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

-- WoW Class Colors
LS["DEATHKNIGHT"] = "DEATHKNIGHT";
LS["DEMONHUNTER"] = "DEMONHUNTER";
LS["DRUID"] = "DRUID";
LS["HUNTER"] = "HUNTER";
LS["MAGE"] = "MAGE";
LS["MONK"] = "MONK";
LS["PALADIN"] = "PALADIN";
LS["PRIEST"] = "PRIEST";
LS["ROGUE"] = "ROGUE";
LS["SHAMAN"] = "SHAMAN";
LS["WARLOCK"] = "WARLOCK";
LS["WARRIOR"] = "WARRIOR";

-- Other WoW Colors
LS["SPELL"] = "SPELL";
LS["SKILL"] = "SKILL";
LS["TALENT"] = "TALENT";
