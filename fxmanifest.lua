fx_version 'cerulean';
game 'gta5';
lua54 'yes';

name 'Library';
author 'Nishikoto <https://www.nishikoto.fr>';
version 'fork-alpha-0.1.3';

shared_script '@lib/imports.lua';
shared_script 'imports.lua';
shared_script 'version.lua';

files {
    'enums/**',
    'github/**',
    'version/**',
    'console/**',
    'resource/**',
    'kvp/**',
    'string/**'
}

dependency 'lib';