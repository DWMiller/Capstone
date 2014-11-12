CORE.extendConfig({
    map: {
        DRAW_INTERVAL: 100, //how often the map redraws
        UPDATE_INTERVAL: 10000, // Rate at which new map data is requested from server   
        imageMapping: {
            'system-terran': 'system-terran',
            'system-desert': 'system-desert',
            'system-gasGiant': 'system-gasGiant',
            'system-ice': 'system-ice',
            'system-molten': 'system-molten',
            'system-volcanic': 'system-volcanic',
            'system-asteroid': 'system-asteroid',
            'fleet': 'fleet',
            'beaker': 'beaker',
            'anchor': 'anchor',
            'mine': 'mine',
            'system-blueGiant': 'system-blueStar',
            'system-blueHyperGiant': 'system-blueStar',
            'system-blueStar': 'system-blueStar',
            'system-whiteDwarf': 'system-whiteStar',
            'system-yellowStar': 'system-yellowStar',
            'system-redDwarf': 'system-redStar',
            'system-redGiant': 'system-redStar',
            'sector-blueGiant': 'sector-blueStar',
            'sector-blueHyperGiant': 'sector-blueStar',
            'sector-blueStar': 'sector-blueStar',
            'sector-whiteDwarf': 'sector-whiteStar',
            'sector-yellowStar': 'sector-yellowStar',
            'sector-redDwarf': 'sector-redStar',
            'sector-redGiant': 'sector-redStar'            
        },
        imagePath: 'assets/images/map/',
        defaultData: {
            scale: 'sector',
            id: 1
        },
        drawScaleFactor: {
            sector: 10,
            system: 20
        },
        mapScaleFactor: {
            sector: 100,
            system: 1000
        }
    }
});
