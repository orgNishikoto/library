ENV = {};
ENV.current_name = lib.current_resource;
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

lib.set_required_resource(ENV.current_name);

-- ❤️ Thanks to Justgod for the require system.