[ "LARs_allGear" ] call BIS_fnc_startLoadingScreen;
LARs_allGear = [];

{
	"
		if ( isNumber( _x >> 'scope' ) && { getNumber( _x >> 'scope' ) isEqualTo 2 } ) then {
			_item = configName _x;
			if !( ( toLower _item ) in LARs_allGear ) then {
				_itemType = _item call BIS_fnc_itemType;
				if !( ( _itemType select 0 ) isEqualTo '' ) then {
					switch ( _itemType select 0 ) do {
						case 'Item' : {
							_nul = LARs_allGear pushBack _item;
						};
						case 'Weapon' : {
							if !( ( _itemType select 1 ) isEqualTo 'VehicleWeapon' ) then {
								if ( ( toLower ( _item call BIS_fnc_baseWeapon )) isEqualTo ( toLower _item ) ) then {
									_nul = LARs_allGear pushBack _item;
								};
							};
						};
						case 'Magazine' : {
							_nul = LARs_allGear pushBack _item;
						};
						case 'Mine' : {
							_nul = LARs_allGear pushBack _item;
						};
						case 'Equipment' : {
							_nul = LARs_allGear pushBack _item;
						};
					};
				};
			};
		};
	"configClasses _x;
}forEach [
	( configFile >> "CfgWeapons" ),
//	( configFile >> "CfgMagazines" ), //Auto added by arsenal
	( configFile >> "CfgVehicles" ),
	( configFile >> "CfgGlasses" )
];

//classes = "isClass _x"conifgclasses ( configFile >> "CfgWeapons" ) +
//"isClass _x"conifgclasses ( configFile >> "CfgVehicles" ) +
//"isClass _x"conifgclasses ( configFile >> "CfgGlasses" );



[ "LARs_allGear" ] call BIS_fnc_endLoadingScreen;