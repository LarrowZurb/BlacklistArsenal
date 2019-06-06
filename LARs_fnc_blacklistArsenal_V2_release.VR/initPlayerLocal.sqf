//_h = [] spawn {
//	while { true } do {
//		_loadingScreens = missionNamespace getVariable ["BIS_fnc_startLoadingScreen_ids",[]];
//		diag_log format[ "%1, %2, %3, %4",
//			[ "finished", "loading" ] select ( isNil "LARs_allGearInit" ),
//			[ "SG: not requested", [ [ "SG not Init", "SG initilised" ] select ( { count _x > 0 }count ( missionNamespace getVariable [ "LARs_sideGear", [] ] ) > 0 ), "SG not loaded" ] select ( isNil "LARs_sideGear" ) ] select isNumber( missionConfigFile >> "LARs_calculateSideGear" ),
//			[ "Data fini", "init Data" ] select ( "LARs_initData" in _loadingScreens ),
//			[ "Boxes fini", "init Boxes" ] select ( "LARs_blacklist" in _loadingScreens )
//		];
//		diag_log "Open loading screens";
//		diag_log "____________________";
//		{
//			diag_log _x;
//		}forEach _loadingScreens;
//		diag_log "____________________";
//		sleep 1;
//	};
//};
