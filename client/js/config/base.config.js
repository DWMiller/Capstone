/**
 * Base config file
 * Not loaded in a specific order, so may override other config files with matching fields
 * Provided as a location for general config settings if an individual file is not appropriate or not preferred.
 * @type {Object}
 */
dmf.extendConfig({
    lobby: {
        UPDATE_INTERVAL: 5000,
    },
    game: {
        UPDATE_INTERVAL: 5000,
        defaultData: {
            scale: 'sector',
            id: 1
        },
    }
});
