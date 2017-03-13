local _G = getfenv();
local LS = ChatSuey.Locales["zhCN"].Strings;

-- Chinese characters cannot be shortened, so we set the "mini"
-- versions of all the channel names to be the normal text.
-- This way, Chinese players can still take advantage of the
-- addon shortening general/trade/etc channels to just the
-- channel number (e.g., [1] instead of [1. 综合]).

LS["P"] = _G.CHAT_MSG_PARTY;
LS["R"] = _G.CHAT_MSG_RAID;
LS["G"] = _G.CHAT_MSG_GUILD;
LS["O"] = _G.CHAT_MSG_OFFICER;
LS["RL"] = _G.CHAT_MSG_RAID_LEADER;
LS["RW"] = _G.CHAT_MSG_RAID_WARNING;
LS["BG"] = _G.CHAT_MSG_BATTLEGROUND;
LS["BL"] = _G.CHAT_MSG_BATTLEGROUND_LEADER;