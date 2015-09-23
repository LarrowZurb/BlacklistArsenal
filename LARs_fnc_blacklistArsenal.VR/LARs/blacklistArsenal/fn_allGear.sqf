#define CFGEntry ( missionConfigFile >> "LARs_calculateSideGear" )

[ "LARs_initData" ] call BIS_fnc_startLoadingScreen;

_fullVersion = false;

_init = ["Preload"] call BIS_fnc_arsenal;

LARs_allGear = BIS_fnc_arsenal_data;
LARs_allGear = LARs_allGear call LARs_fnc_tolower;

if ( isNumber( CFGEntry ) && { getNumber( CFGEntry ) > 0 } ) then {
	[] call LARs_fnc_sideGear;
};

[ "LARs_initData" ] call BIS_fnc_endLoadingScreen;

LARs_allGearInit = true;