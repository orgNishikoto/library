local eLevel = nlib.enum.eLevel
local debug_active = (GetConvar('nishikoto:library:debug', 'false') == 'true') and true or false;

---@param level eLevel
---@param message string
return function(level, message)
    if (not message or type(message) ~= 'string') then return end;
    local time = lib.is_server and os.date('%x %X') or '';
    local level = (not level) and eLevel.Info or level;
    local color = '^4';
    
    if (level == 'ERROR') then
        color = '^8';
    elseif (level == 'FATAL') then
        color = '^1';
    elseif (level == 'SUCCESS') then
        color = '^2';
    elseif (level == 'WARNING') then
        color = '^3';
    end

    if (debug_active) then
        _print(('^7[^5%s^7] ^6DEBUG %s%s ^0%s^0'):format(time, color, level, message));
    end
end