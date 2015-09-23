
LARs_sideGear = [
	[  ],	//east
	[  ],	//west
	[  ],	//independent
	[  ]	//civilian
];

_fnc_LinkedWeaponItems = {
	private [ "_item" ];
	"
		if ( isText( _x >> 'Item' ) ) then {
			_item = getText( _x >> 'Item' );
			if ( count _item > 0 && { !( _item in _gear ) } ) then {
				_nul = _gear pushBack ( getText( _x >> 'Item' ) );
			};
		};
	"configClasses _this;
};

_fnc_transClasses = {
	params[
		[ "_class", ""],
		[ "_type", ""]
	];
	"
		if ( isText( _x >> _type ) ) then {
			_item = getText( _x >> _type );
			if !( _item in _gear ) then {
				_nul = _gear pushBack _item;
			};
		};
	"configClasses _class;
};


"
	_cfgName = configname _x;
	switch ( true ) do {

		comment'Soldiers';
		case ( _cfgName iskindof 'CAManBase' && isNumber( _x >> 'side' ) ) : {
			_side = getNumber( _x >> 'side' );
			if ( _side in [0,1,2,3] ) then {
				_gear = ( LARs_sideGear select _side );
				{
					{
						if ( count _x > 0 && { !( _x in _gear ) } ) then {
							_nul = _gear pushback _x;
						};
					}foreach _x;
				}foreach [
					getArray ( _x >> 'allowedHeadgear' ),
					getArray( _x >> 'allowedHeadgearB' ),
					getArray( _x >> 'allowedHeadgearSides' ),
					getArray( _x >> 'allowedUniformSides' ),
					getArray( _x >> 'linkedItems' ),
					getArray( _x >> 'magazines' ),
					getArray( _x >> 'RespawnItems' ),
					getArray( _x >> 'respawnLinkedItems' ),
					getArray( _x >> 'respawnMagazines' )
				];

				{
					_weapon = _x;
					if !( _weapon in [ 'Throw', 'Put' ] ) then {
						_base = _x call BIS_fnc_baseWeapon;
						if !( _base in _gear ) then {
							_nul = _gear pushback _base;
						};

						( configFile >> 'CfgWeapons' >> _weapon >> 'linkedItems' ) call _fnc_LinkedWeaponItems;
					};
					{
						_mags = if ( _x isequalto 'this' ) then {
							getArray( configFile >> 'CfgWeapons' >> _weapon >> 'magazines' )
						}else{
							getArray( configFile >> 'CfgWeapons' >> _weapon >> _x >> 'magazines' )
						};
						{
							if !( _x in _gear ) then {
								_nul = _gear pushBack _x;
							};
						}forEach _mags;
					}foreach getArray( configfile >> 'CfgWeapons' >> _weapon >> 'muzzles' );

				}foreach ( getArray( _x >> 'weapons' ) );

				if !( getText( _x >> 'uniformClass' ) in _gear ) then {
					_nul = _gear pushback getText( _x >> 'uniformClass' );
				};

				if !( getText( _x >> 'backpack' ) in _gear ) then {
					_nul = _gear pushback getText( _x >> 'backpack' );
				};

				LARs_sideGear set [ _side, _gear ];
			};
		};

		comment'special backpacks';
		case ( _cfgName isKindOf 'ReammoBox' && ( isText( _x >> 'faction' ) ) ) : {
			_faction = getText( _x >> 'faction' );
			_side = getNumber( configfile >> 'CfgFactionClasses' >> _faction >> 'side' );
			if ( _side in [0,1,2,3] ) then {
				_gear = LARs_sideGear select _side;
				if !( _cfgName in _gear ) then {
					_nul = _gear pushBack _cfgName;
				};
				LARs_sideGear set [ _side, _gear ];
			};
		};

		comment'Ammo boxes';
		case ( _cfgName iskindof 'ReammoBox_F' ) : {
			_side = switch ( tolower( ( _cfgName splitstring '_' ) select 1 ) ) do {
				case ( 'east' ) : {
					0
				};
				case ( 'fia' ) : {
					0
				};
				case ( 'nato' ) : {
					1
				};
				case ( 'ind' ) : {
					2
				};
			};
			if ( _side in [0,1,2,3] ) then {
				_gear = LARs_sideGear select _side;
				{
					_x call _fnc_transClasses;
				}foreach [
					[ ( _x >> 'TransportItems' ), 'name' ],
					[ ( _x >> 'TransportMagazines' ), 'magazine' ],
					[ ( _x >> 'TransportWeapons' ), 'weapon' ]
				];
				LARs_sideGear set [ _side, _gear ];
			};
		};

	};
"configClasses ( configFile >> "CfgVehicles" );

{
	_gear = _x - [ "" ];
	_gear = _gear arrayIntersect _gear;
	LARs_sideGear set [ _forEachIndex, _gear ];
}forEach LARs_sideGear;
LARs_sideGear = LARs_sideGear call LARs_fnc_toLower;

diag_log 'gear finished';