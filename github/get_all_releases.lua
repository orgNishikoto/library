---@param callback fun(data: table)
---@param name string
---@param repo string
return function(callback, name, repo)
    if (type(name) ~= 'string') then return end;
    if (type(repo) ~= 'string') then return end;

    local api_link = ('https://api.github.com/repos/%s/%s/releases'):format(name, repo);

    PerformHttpRequest(api_link, function(status, result)
        if (status ~= 200) then return; end
        local data = json.decode(result);

        if (type(data) == 'string') then
            callback(data);
        end
    end, 'GET');
end