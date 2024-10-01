AddEventHandler('onResourceStart', function(resName)
    if (resName ~= ENV.name) then return end;

    local version = GetResourceMetadata(ENV.name, 'version', GetNumResourceMetadata(ENV.name, 'version') - 1);
    local status = nlib.version.compare('orgNishikoto', 'library', version:match('%d%.%d+%.%d+'));

    nlib.console.print(('^7[^0Library^7] ^4Version ^6%s^0'):format(version));

    if (status == 'lower') then
        nlib.console.print(('^7[^8--------^7] ^0Mise à jour disponible (%s)'):format('https://github.com/orgNishikoto/library/releases/latest'));
    elseif (status == 'upper') then
        nlib.console.print(('^7[^3--------^7] ^0Version supérieur, mise à jour possible ^7(^5%s^7)^0'):format('https://github.com/orgNishikoto/library/releases/latest'));
    elseif (status == 'equal') then
        nlib.console.success(('^7[^2--------^7] ^0Vous êtes à jour en ^6%s.^0'):format(version));
    elseif (status == 'error') then
        nlib.console.err('Une erreur lors de la récupération de version de dépôt \'library\' est survenue. Si le problème persiste veuillez contacter le créateur de la bibliothèque ou de la version de la bibliothèque que vous utilisez.');
    end
end)