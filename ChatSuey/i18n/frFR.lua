local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local frFR = ChatSuey.Locale:new();
local LS = frFR.Strings;

ChatSuey.Locales = ChatSuey.Locales or ChatSuey.LocaleTable:new(frFR);
ChatSuey.Locales["frFR"] = frFR;

-- CSS2 Colors
LS["BLACK"] = "NOIR";
LS["GRAY"] = "GRIS";
LS["SILVER"] = "ARGENT";
LS["WHITE"] = "BLANC";
LS["PURPLE"] = "VIOLET";
LS["MAROON"] = "MARRON";
LS["RED"] = "ROUGE";
LS["FUCHSIA"] = "FUCHSIA";
LS["GREEN"] = "VERT";
LS["LIME"] = "VERTCLAIR";
LS["OLIVE"] = "OLIVE";
LS["YELLOW"] = "JAUNE";
LS["NAVY"] = "BLEUMARINE";
LS["BLUE"] = "BLEU";
LS["TEAL"] = "BLEUVERT";
LS["AQUA"] = "AQUA";
LS["ORANGE"] = "ORANGE";

-- WoW Item Quality Colors
LS["POOR"] = "MAUVAIS";
LS["COMMON"] = "COMMUN";
LS["UNCOMMON"] = "MAGIQUE";
LS["RARE"] = "RARE";
LS["EPIC"] = "EPIQUE";
LS["LEGENDARY"] = "LEGENDAIRE";
LS["ARTIFACT"] = "PRODIGIEUX";
LS["HEIRLOOM"] = "HERITAGE";
LS["TOKEN"] = "JETON";
LS["BLIZZARD"] = "BLIZZARD";

-- WoW Class Colors
LS["DEATHKNIGHT"] = "CHEVALIERDELAMORT";
LS["DEMONHUNTER"] = "CHASSEURDEDEMONS";
LS["DRUID"] = "DRUIDE";
LS["HUNTER"] = "CHASSEUR";
LS["MAGE"] = "MAGE";
LS["MONK"] = "MOINE";
LS["PALADIN"] = "PALADIN";
LS["PRIEST"] = "PRETRE";
LS["ROGUE"] = "VOLEUR";
LS["SHAMAN"] = "CHAMAN";
LS["WARLOCK"] = "DEMONISTE";
LS["WARRIOR"] = "GUERRIER";

-- Other WoW Colors
LS["SPELL"] = "SORTS";
LS["SKILL"] = "ABILITE";
LS["TALENT"] = "TALENT";
