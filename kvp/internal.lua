local _TYPE = {
    ['number'] = {
        authorized = true,
        value = 'INT'
    },
    ['float'] = {
        authorized = true,
        value = 'FLOAT'
    },
    ['string'] = {
        authorized = true,
        value = 'STR'
    },
    ['boolean'] = {
        authorized = true,
        value = 'BOOL'
    },
    ['table'] = {
        authorized = true,
        value = 'TBL'
    }
};

---@class KVP.Internal
local intKVP = {};

---@param valtype string
---@return boolean
local function type_is_authorized(valtype)
    if (not valtype or nlib.string.type(valtype) ~= 'string') then return end;
    return _TYPE[valtype].authorized;
end


---@param _type string
---@param name string
---@return string
local function format_key(valtype, name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if (not valtype or nlib.string.type(valtype) ~= 'string') then return end;
    return ('%s:%s(%s)'):format('NISHILIB_', name, _TYPE[valtype].value);
end

---@param valtype string
---@param name string
---@return boolean
local function is_kvp_exist(valtype, name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if (not valtype or nlib.string.type(valtype) ~= 'string') then return end;

    if (valtype == 'number') then
        return GetResourceKvpInt(format_key(valtype, name)) and true or false;
    elseif (valtype == 'float') then
        return GetResourceKvpFloat(format_key(valtype, name)) and true or false;
    else
        return GetResourceKvpString(format_key(valtype, name)) and true or false;
    end
end

---@param value string
---@return type, string
local function prepare_value_and_typeof(value)
    local typeof = nlib.string.type(value);

    if (typeof == 'boolean') then
        value = tostring(value);
    elseif (typeof == 'table') then
        value = tostring(json.encode(value));
    end 

    return typeof, value;
end

function intKVP.Set(name, value)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if (not value) then return end;

    local typeof, _value = prepare_value_and_typeof(value);

    if (not type_is_authorized(typeof)) then
        error('Type of value is not authorized!', 3);
    end;

    if (typeof == 'number') then
        SetResourceKvpInt(format_key(typeof, name), _value);
    elseif (typeof == 'float') then
        SetResourceKvpFloat(format_key(typeof, name), _value);
    else
        SetResourceKvp(format_key(typeof, name), _value);
    end
end

---@param name string
---@return number
function intKVP.GetNumber(name)
    if (not name) then return end;
    local exist = is_kvp_exist('number', name);
    return exist and GetResourceKvpInt(format_key('number', name)) or 0;
end

---@param name string
---@return number
function intKVP.GetInt(name)
    return intKVP.GetNumber(name);
end

---@param name string
---@return float
function intKVP.GetFloat(name)
    if (not name) then return end;
    local exist = is_kvp_exist('float', name);
    return exist and GetResourceKvpFloat(format_key('float', name)) or 0.0;
end

---@param name string
---@return string
function intKVP.GetString(name)
    if (not name) then return end;
    local exist = is_kvp_exist('string', name);
    return exist and GetResourceKvpString(format_key('string', name)) or '';
end

---@param name string
---@return table
function intKVP.GetTable(name)
    if (not name) then return end;
    local exist = is_kvp_exist('table', name);
    return exist and json.decode(GetExternalKvpString(format_key('table', name))) or {};
end

---@param name string
---@return boolean
function intKVP.GetBoolean(name)
    if (not name) then return end;
    local exist = is_kvp_exist('boolean', name);
    return exist and nlib.string.tobool(GetExternalKvpString(format_key('boolean', name))) or false;
end

---@param name string
---@return boolean
function intKVP.ExistNumber(name)
    if (not name) then return end;
    return is_kvp_exist('number', name);
end

---@param name string
---@return boolean
function intKVP.ExistInt(name)
    return intKVP.ExistNumber(name);
end

---@param name string
---@return boolean
function intKVP.ExistFloat(name)
    if (not name) then return end;
    return is_kvp_exist('float', name);
end

---@param name string
---@return boolean
function intKVP.ExistString(name)
    if (not name) then return end;
    return is_kvp_exist('string', name);
end

---@param name string
---@return boolean
function intKVP.ExistTable(name)
    if (not name) then return end;
    return is_kvp_exist('table', name);
end

---@param name string
---@return boolean
function intKVP.ExistBoolean(name)
    if (not name) then return end;
    return is_kvp_exist('boolean', name);
end

---@param name string
function intKVP.DeleteNumber(name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if is_kvp_exist('number', name) then DeleteResourceKvp(format_key('number', name)) end;
end

---@param name string
function intKVP.DeleteInt(name)
    intKVP.DeleteNumber(name)
end

---@param name string
function intKVP.DeleteFloat(name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if is_kvp_exist('float', name) then print('deleted') DeleteResourceKvp(format_key('float', name)) end;
end

---@param name string
function intKVP.DeleteTable(name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if is_kvp_exist('table', name) then DeleteResourceKvp(format_key('table', name)) end;
end

---@param name string
function intKVP.DeleteBoolean(name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if is_kvp_exist('boolean', name) then DeleteResourceKvp(format_key('boolean', name)) end;
end

---@param name string
function intKVP.DeleteString(name)
    if (not name or nlib.string.type(name) ~= 'string') then return end;
    if is_kvp_exist('string', name) then DeleteResourceKvp(format_key('string', name)) end;
end

return intKVP;