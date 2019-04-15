//add or remove an array of items from arsenals cargo
//If the arsenal did not previously exist pass it to be init

if ( !( params[
	[ "_box", objNull, [ objNull ] ]
] ) || { isNull _box } ) exitWith {
	"Invalid object for arsenal box" call BIS_fnc_error;
	false
};

( _this select [ 1, (count _this)-1 ] ) params[
	[ "_arsenal", "", [ "" ] ],
	[ "_items", [], [ [], "" ] ],
	[ "_add", true, [ true ] ]
];
if ( typeName _items isEqualTo typeName "" ) then {
	_items = [ _items ];
};

//_cargoDef = [ "item", "weapon", "magazine", "backpack" ];
private [ "_oldItems", "_fnc_change", "_array", "_nul", "_itemType" ];

_oldItems = [ _box, _arsenal ] call LARs_fnc_getArsenal;

_fnc_change = {
	params[
		[ "_item", "" ],
		[ "_index", 0 ]
	];

	_array = _oldItems select _index;
	if ( _add ) then {
		_nul = _array pushBack _item;
	}else{
		_array = _array - [ _item ];
	};
	_oldItems set [ _index, _array ];

};

{
	_itemType = _x call BIS_fnc_itemType;
	switch ( _itemType select 0 ) do {
		case ( "Item" ) : {
			[ _x, 0 ] call _fnc_change;
		};
		case ( "Weapon" ) : {
			[ _x, 1 ] call _fnc_change;
		};
		case ( "Magazine" ) : {
			[ _x, 2 ] call _fnc_change;
		};
		case ( "Mine" ) : {
			[ _x, 2 ] call _fnc_change;
		};
		case ( "Equipment" ) : {
			if ( _itemType select 2 isEqualTo "Backpack" ) then {
				[ _x, 3 ] call _fnc_change;
			}else{
				[ _x, 0 ] call _fnc_change;
			};
		};
	};
}forEach _items;

_box setVariable [ format[ "LARs_Arsenal_cargo_%1", _arsenal ], _oldItems ];

if !( _arsenal in (( [ _box ] call LARs_fnc_getArsenal ) select 0 ) ) then {
	[ _box, _arsenal ] call LARs_fnc_initArsenal;
};

true