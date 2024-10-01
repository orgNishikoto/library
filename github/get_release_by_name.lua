---@param callback fun(data: table)
---@param name string
---@param repo string
---@param releasename string
---@return table
return function(callback, name, repo, releasename)
    if (type(name) ~= 'string') then return end;
    if (type(repo) ~= 'string') then return end;

    local all_releases = github.get_all_releases(name, repo);

    for _,data in pairs(all_releases) do
        if (releasename == data.tag_name) then
            callback(data);
        end
    end
end