---@param resourcename string
---@return string
return function(resourcename)
    if (type(resourcename) ~= 'string') then return end;
    return GetResourceMetadata(resourcename, 'author', GetNumResourceMetadata(resourcename, 'author') - 1);
end