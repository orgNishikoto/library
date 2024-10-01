---@param callback fun(version: string, raw: string)
---@param name string
---@param repo string
return function(callback, name, repo)
    if (type(name) ~= 'string') then return end;
    if (type(repo) ~= 'string') then return end;

    local api_link = ('https://api.github.com/repos/%s/%s/releases/latest'):format(name, repo);

    PerformHttpRequest(api_link, function(status, result)
        if (status ~= 200) then return; end
        local data = json.decode(result);

        if (type(data.tag_name) == 'string') then
            callback(data.tag_name:match('%d%.%d+%.%d+'), data.tag_name);
        end
    end, 'GET');
end