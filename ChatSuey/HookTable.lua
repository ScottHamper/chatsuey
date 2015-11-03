local _G = getfenv();
local HookTable = {};

function HookTable:new()
    local hookTable = {};

    setmetatable(hookTable, {
        __index = self,
        __mode = "k",
    });

    return hookTable;
end

local noOp = function () end;

function HookTable:RegisterScript(frame, script, handler)
    self[frame] = self[frame] or {};

    if self[frame][script] then
        local err = string.format("Attempted to register multiple \"%s\" handlers for the same frame", script);
        error(err);
    end

    self[frame][script] = frame:GetScript(script) or noOp;
    frame:SetScript(script, handler);
end

function HookTable:RegisterFunc(table, funcName, func)
    self[table] = self[table] or {};

    if self[table][funcName] then
        local err = string.format("Attempted to register multiple \"%s\" hooks for the same table", funcName);
        error(err);
    end

    self[table][funcName] = table[funcName] or noOp;
    table[funcName] = func;
end

_G.ChatSuey.HookTable = HookTable;