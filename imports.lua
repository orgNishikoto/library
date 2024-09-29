ENV = {};
ENV.current_name = GetCurrentResourceName();
ENV.name = 'library'; 

if (ENV.name ~= ENV.current_name) then
    local state = GetResourceState(ENV.name);

    if (not state:find('start')) then
        print('This library cant be started after your module!');
    end
end

local Modules = {};
local _require = require;
local _path = './?.lua;';

function require(modname, resource)
    if (not type(modname) ~= 'string') then return end;

    if (modname:find('.lua')) then
        modname = modname:gsub('.lua', '');
    end

    if (not resource) then
        resource = ENV.current_name;
    end

    local moduleid = ('%s:%s'):format(resource, modname);
    local module = Modules[moduleid];

    if (not module) then
        if (module == false) then 
            error(("^1circular-dependency occurred when loading module '%s'^0"):format(modname), 0);
        end;

        local success, result = pcall(_require, modname);

        if (success) then
            Modules[moduleid] = result;
            return result;
        end

        local modpath = modname:gsub('%.', '/');

        for path in _path:gmatch('[^;]+') do
            local script = path:gsub('?', modpath):gsub('%.+%/+', '');
            local resourceFile = LoadResourceFile(resource, script);

            if (type(resourceFile) == 'string') then
                Modules[moduleid] = false;
                script = ('@@%s/%s'):format(resource, script)

                local chunk, err = load(resourceFile, script)

                if (err or not chunk) then
                    Modules[moduleid] = nil;
                    return error(err or ("Unable to load module '%s'"):format(modname), 0);
                end

                module = chunk(modname) or true;
                Modules[moduleid] = module;

                return module;
            end
        end

        return error(("module ^7\'^3%s^7\'^1 not found^0"):format(modname), 0);
    end

    return module;
end

-- ❤️ Thanks to Justgod for the require system.