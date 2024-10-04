---@param resourcename string
---@return string
return function(resourcename)
    if (type(resourcename) ~= 'string') then return end;
    return GetResourceMetadata(resourcename, 'version', GetNumResourceMetadata(resourcename, 'version') - 1);
end