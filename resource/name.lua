---@param resourcename string
---@return string
return function(resourcename)
    if (type(resourcename) ~= 'string') then return end;
    return GetResourceMetadata(resourcename, 'name', GetNumResourceMetadata(resourcename, 'name') - 1);
end