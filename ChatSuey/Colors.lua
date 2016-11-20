local _G = getfenv();
local ChatSuey = _G.ChatSuey;

-- English constants for accessing colors in code from dependent addons.
ChatSuey.Colors = {
    -- CSS2 Colors
    BLACK = "ff000000",
    GRAY = "ff808080",
    SILVER = "ffc0c0c0",
    WHITE = "ffffffff",
    PURPLE = "ff800080",
    MAROON = "ff800000",
    RED = "ffff0000",
    FUCHSIA = "ffff00ff",
    GREEN = "ff008000",
    LIME = "ff00ff00",
    OLIVE = "ff808000",
    YELLOW = "ffffff00",
    NAVY = "ff000080",
    BLUE = "ff0000ff",
    TEAL = "ff008080",
    AQUA = "ff00ffff",
    ORANGE = "ffffa500",

    -- WoW Item Quality Colors
    POOR = "ff9d9d9d",
    COMMON = "ffffffff",
    UNCOMMON = "ff1eff00",
    RARE = "ff0070dd",
    EPIC = "ffa335ee",
    LEGENDARY = "ffff8000",
    ARTIFACT = "ffe6cc80",
    HEIRLOOM = "ffe6cc80",
    TOKEN = "ff00ccff",
    BLIZZARD = "ff00ccff",

    -- WoW Class Colors
    DEATHKNIGHT = "ffc41f3b",
    DEMONHUNTER = "ffa330c9",
    DRUID = "ffff7d0a",
    HUNTER = "ffabd473",
    MAGE = "ff69ccf0",
    MONK = "ff00ff96",
    PALADIN = "fff58cba",
    PRIEST = "ffffffff",
    ROGUE = "fffff569",
    SHAMAN = "ff0070de",
    WARLOCK = "ff9482c9",
    WARRIOR = "ffc79c6e",

    -- Other WoW Colors
    SPELL = "ff71d5ff",
    SKILL = "ffffd000",
    TALENT = "ff4e96f7",
};

-- Localized constants for accessing colors from user-entered strings.
local C = ChatSuey.Colors;
local LS = ChatSuey.Locales[_G.GetLocale()].Strings;
C[LS["BLACK"]] = C.BLACK;
C[LS["GRAY"]] = C.GRAY;
C[LS["SILVER"]] = C.SILVER;
C[LS["WHITE"]] = C.WHITE;
C[LS["PURPLE"]] = C.PURPLE;
C[LS["MAROON"]] = C.MAROON;
C[LS["RED"]] = C.RED;
C[LS["FUCHSIA"]] = C.FUCHSIA;
C[LS["GREEN"]] = C.GREEN;
C[LS["LIME"]] = C.LIME;
C[LS["OLIVE"]] = C.OLIVE;
C[LS["YELLOW"]] = C.YELLOW;
C[LS["NAVY"]] = C.NAVY;
C[LS["BLUE"]] = C.BLUE;
C[LS["TEAL"]] = C.TEAL;
C[LS["AQUA"]] = C.AQUA;
C[LS["ORANGE"]] = C.ORANGE;
C[LS["POOR"]] = C.POOR;
C[LS["COMMON"]] = C.COMMON;
C[LS["UNCOMMON"]] = C.UNCOMMON;
C[LS["RARE"]] = C.RARE;
C[LS["EPIC"]] = C.EPIC;
C[LS["LEGENDARY"]] = C.LEGENDARY;
C[LS["ARTIFACT"]] = C.ARTIFACT;
C[LS["HEIRLOOM"]] = C.HEIRLOOM;
C[LS["TOKEN"]] = C.TOKEN;
C[LS["BLIZZARD"]] = C.BLIZZARD;
C[LS["DEATHKNIGHT"]] = C.DEATHKNIGHT;
C[LS["DEMONHUNTER"]] = C.DEMONHUNTER;
C[LS["DRUID"]] = C.DRUID;
C[LS["HUNTER"]] = C.HUNTER;
C[LS["MAGE"]] = C.MAGE;
C[LS["MONK"]] = C.MONK;
C[LS["PALADIN"]] = C.PALADIN;
C[LS["PRIEST"]] = C.PRIEST;
C[LS["ROGUE"]] = C.ROGUE;
C[LS["SHAMAN"]] = C.SHAMAN;
C[LS["WARLOCK"]] = C.WARLOCK;
C[LS["WARRIOR"]] = C.WARRIOR;
C[LS["SPELL"]] = C.SPELL;
C[LS["SKILL"]] = C.SKILL;
C[LS["TALENT"]] = C.TALENT;