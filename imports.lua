ENV = {};
ENV.current_name = GetCurrentResourceName();
ENV.name = 'library'; 

lib.set_required_resource(ENV.name);

nlib = {};

nlib.enum = require 'enums.index';
nlib.string = require 'string.index';
nlib.console = require 'console.index';
nlib.resource = require 'resource.index';
nlib.kvp = require 'kvp.index';

if (lib.is_server) then
    nlib.github = require 'github.index';
    nlib.version = require 'version.index';
end

-- ❤️ Thanks to Justgod for the require system.