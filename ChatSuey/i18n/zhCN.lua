local _G = getfenv();
local ChatSuey = _G.ChatSuey;
local zhCN = ChatSuey.Locale:new();
local LS = zhCN.Strings;

ChatSuey.Locales = ChatSuey.Locales or ChatSuey.LocaleTable:new(zhCN);
ChatSuey.Locales["zhCN"] = zhCN;

-- CSS2 Colors
LS["BLACK"] = "黑";
LS["GRAY"] = "灰";
LS["SILVER"] = "银";
LS["WHITE"] = "白";
LS["PURPLE"] = "紫";
LS["MAROON"] = "褐";
LS["RED"] = "红";
LS["FUCHSIA"] = "紫红";
LS["GREEN"] = "绿";
LS["LIME"] = "清宁绿";
LS["OLIVE"] = "橄榄绿";
LS["YELLOW"] = "黄";
LS["NAVY"] = "藏青";
LS["BLUE"] = "蓝";
LS["TEAL"] = "蓝绿";
LS["AQUA"] = "水";
LS["ORANGE"] = "橙";

-- WoW Item Quality Colors
LS["POOR"] = "低劣";
LS["COMMON"] = "一般";
LS["UNCOMMON"] = "优秀";
LS["RARE"] = "精良";
LS["EPIC"] = "史诗";
LS["LEGENDARY"] = "传奇";
LS["ARTIFACT"] = "神器";
LS["HEIRLOOM"] = "传家宝";
LS["TOKEN"] = "徽章";
LS["BLIZZARD"] = "暴雪";

-- WoW Class Colors
LS["DEATHKNIGHT"] = "死亡骑士";
LS["DEMONHUNTER"] = "恶魔猎人";
LS["DRUID"] = "德鲁伊";
LS["HUNTER"] = "猎人";
LS["MAGE"] = "法师";
LS["MONK"] = "武僧";
LS["PALADIN"] = "圣骑士";
LS["PRIEST"] = "牧师";
LS["ROGUE"] = "盗贼";
LS["SHAMAN"] = "萨满祭司";
LS["WARLOCK"] = "术士";
LS["WARRIOR"] = "战士";

-- Other WoW Colors
LS["SPELL"] = "法术";
LS["SKILL"] = "技能";
LS["TALENT"] = "天赋";
