<?php
define('TURN_TIME', 60); // Frequency of game turns, responsible for income, ship building
define('TURN_QUICK_TIME', 10); // Frequency of combat cycles

define('FLEET_SPEED',100);
define('SYSTEM_DISTANCE_MOD', 3); //multiples to make travel between stars longer
define('USER_UNACTIVATED', 0);
define('MIN_PLAYERS', 2);

define('USER_IDLE', 1);
define('USER_QUEUED', 2);
define('USER_PLAYING', 3);
define('USER_BANNED', 4);


//structure base costs
define('MINE_BASE', 1);
define('SHIPYARD_BASE', 1.5);
define('LAB_BASE', 2);