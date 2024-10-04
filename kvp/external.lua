---@class KVP.External
local extKVP = {};

local function is_kvp_exist(resourcename, valtype, name)
    if (not resourcename) then return end;
    if (not name or type(name) ~= 'string') then return end;
    if (not valtype or type(valtype) ~= 'string') then return end;

    if (valtype == 'number') then
        return GetExternalKvpInt(name) and true or false;
    elseif (valtype == 'float') then
        return GetExternalKvpFloat(name) and true or false;
    elseif (valtype == 'string') then
        return GetExternalKvpString(name) and true or false;
    end
end

---@param resource string
---@param name string
---@return number
function extKVP.GetNumber(resource, name)
    local resname = not resource and GetCurrentResourceName() or resource;
    if (not name or type(name) ~= 'string') then return end;
    return is_kvp_exist(resname, 'number', name) and GetExternalKvpInt(resname, name) or 0;
end

---@param resource string
---@param name string
---@return number
function extKVP.GetString(resource, name)
    local resname = not resource and GetCurrentResourceName() or resource;
    if (not name or type(name) ~= 'string') then return end;
    return is_kvp_exist(resname, 'string', name) and GetExternalKvpInt(resname, name) or 0;
end

---@param resource string
---@param name string
---@return number
function extKVP.GetFloat(resource, name)
    local resname = not resource and GetCurrentResourceName() or resource;
    if (not name or type(name) ~= 'string') then return end;
    return is_kvp_exist(resname, 'float', name) and GetExternalKvpFloat(resname, name) or 0.0;
end

return extKVP;