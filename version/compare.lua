---@param username string
---@param reponame string
---@param version string
---@return table
return function(username, reponame, version)
    if (type(username) ~= 'string') then return end;
    if (type(reponame) ~= 'string') then return end;
    if (type(version) ~= 'string') then return end;
    
    local waiting = true;
    local result;

    nlib.github.get_latest_release(function(latestversion, raw)
        if (latestversion) then 
            if (version > latestversion) then
                result = 'upper';
            elseif (version < latestversion) then
                result = 'lower';
            elseif (version == latestversion) then
                result = 'equal';
            end
        else
            result = 'error';
        end

        waiting = false;
    end, username, reponame)

    while (waiting) do
        Wait(100);
    end
    
    return result;
end