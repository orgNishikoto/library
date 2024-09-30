---@param username string
---@param reponame string
---@param version string
---@return string
return function(username, reponame, version)
    if (type(username) ~= 'string') then return end;
    if (type(reponame) ~= 'string') then return end;
    if (type(version) ~= 'string') then return end;
    
    local waiting = true;
    local result = 'error';

    nlib.github.get_latest_release(function(latestversion, raw)
        if (latestversion) then 
            if (latestversion > version) then
                result = 'lower';
            elseif (latestversion < version) then
                result = 'upper';
            elseif (latestversion == version) then
                result = 'equal';
            end
        end

        waiting = false;
    end, username, reponame)

    while (waiting) do
        Wait(100);
    end

    return result;
end