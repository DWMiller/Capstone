/**
 * Base config file
 * Not loaded in a specific order, so may override other config files with matching fields
 * Provided as a location for general config settings if an individual file is not appropriate or not preferred.
 * @type {Object}
 */
CORE.extendConfig({
	lobby: {
		UPDATE_INTERVAL: 5000,
	}
});