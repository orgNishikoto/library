---@param username string
---@param reponame string
---@param truncate boolean
---@param return string
return function(username, reponame, truncate)
    if (type(username) ~= 'string') then return end;
    if (type(reponame) ~= 'string') then return end;

    local waiting = true;
    local result;

    nlib.github.get_latest_release(function(latestversion, raw)
        if (latestversion) then
            if (truncate) then
                result = latestversion;
            else    
                result = raw;    
            end
        end

        waiting = false;
    end, username, reponame)
    
    while (waiting) do
        Wait(100);
    end

    return result;
end