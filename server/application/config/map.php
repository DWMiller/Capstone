<?php
define('MAP_SIZE', 1000); // default width/height of map regions


/**************************** Stars ************************/
$GLOBALS['starTypes'][] = 'blueGiant';
$GLOBALS['starTypes'][] = 'blueHyperGiant';
$GLOBALS['starTypes'][] = 'blueStar';
$GLOBALS['starTypes'][] = 'whiteDwarf';
$GLOBALS['starTypes'][] = 'yellowStar';
$GLOBALS['starTypes'][] = 'redDwarf';
$GLOBALS['starTypes'][] = 'redGiant';

$GLOBALS['locations']['stars']['blueGiant']['heat'] = 4;
$GLOBALS['locations']['stars']['blueGiant']['minSize'] = 35;
$GLOBALS['locations']['stars']['blueGiant']['maxSize'] = 59;

$GLOBALS['locations']['stars']['blueHyperGiant']['heat'] = 5;
$GLOBALS['locations']['stars']['blueHyperGiant']['minSize'] = 60;
$GLOBALS['locations']['stars']['blueHyperGiant']['maxSize'] = 10000;

$GLOBALS['locations']['stars']['blueStar']['heat'] = 3;
$GLOBALS['locations']['stars']['blueStar']['minSize'] = 10;
$GLOBALS['locations']['stars']['blueStar']['maxSize'] = 34;


$GLOBALS['locations']['stars']['whiteDwarf']['heat'] = 1;
$GLOBALS['locations']['stars']['whiteDwarf']['minSize'] = 0;
$GLOBALS['locations']['stars']['whiteDwarf']['maxSize'] = 10;


$GLOBALS['locations']['stars']['yellowStar']['heat'] = 2;
$GLOBALS['locations']['stars']['yellowStar']['minSize'] = 15;
$GLOBALS['locations']['stars']['yellowStar']['maxSize'] = 39;


$GLOBALS['locations']['stars']['redDwarf']['heat'] = 1;
$GLOBALS['locations']['stars']['redDwarf']['minSize'] = 0;
$GLOBALS['locations']['stars']['redDwarf']['maxSize'] = 14;


$GLOBALS['locations']['stars']['redGiant']['heat'] = 1;
$GLOBALS['locations']['stars']['redGiant']['minSize'] = 40;
$GLOBALS['locations']['stars']['redGiant']['maxSize'] = 55;

/**************************** Planets ************************/
$GLOBALS['locations']['planets']['terran']['metal'] = 3;
$GLOBALS['locations']['planets']['terran']['minSize'] = 5;
$GLOBALS['locations']['planets']['terran']['maxSize'] = 15;
$GLOBALS['locations']['planets']['terran']['capacity'] = 8;

$GLOBALS['locations']['planets']['desert']['metal'] = 2;
$GLOBALS['locations']['planets']['desert']['fertility'] = 1;
$GLOBALS['locations']['planets']['desert']['minSize'] = 5;
$GLOBALS['locations']['planets']['desert']['maxSize'] = 20;
$GLOBALS['locations']['planets']['desert']['capacity'] = 10;
$GLOBALS['locations']['planets']['desert']['climate'] = 1;

$GLOBALS['locations']['planets']['ice']['metal'] = 1;
$GLOBALS['locations']['planets']['ice']['minSize'] = 0;
$GLOBALS['locations']['planets']['ice']['maxSize'] = 10;
$GLOBALS['locations']['planets']['ice']['capacity'] = 10;

$GLOBALS['locations']['planets']['molten']['metal'] = 5;
$GLOBALS['locations']['planets']['molten']['minSize'] = 0;
$GLOBALS['locations']['planets']['molten']['maxSize'] = 12;
$GLOBALS['locations']['planets']['molten']['capacity'] = 1;

$GLOBALS['locations']['planets']['volcanic']['metal'] = 6;
$GLOBALS['locations']['planets']['volcanic']['minSize'] = 0;
$GLOBALS['locations']['planets']['volcanic']['maxSize'] = 10;
$GLOBALS['locations']['planets']['volcanic']['capacity'] = 6;

$GLOBALS['locations']['planets']['gasGiant']['metal'] = 0;
$GLOBALS['locations']['planets']['gasGiant']['minSize'] = 15;
$GLOBALS['locations']['planets']['gasGiant']['maxSize'] = 10000;
$GLOBALS['locations']['planets']['gasGiant']['capacity'] = 0;

/**************************** Other ************************/

$GLOBALS['locations']['special']['wormhole']['size'] = 20;

