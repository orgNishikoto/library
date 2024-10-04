---@param resourcename string
---@return string
return function(resourcename)
    if (type(resourcename) ~= 'string') then return end;
    return GetResourceMetadata(resourcename, 'description', GetNumResourceMetadata(resourcename, 'description') - 1);
end