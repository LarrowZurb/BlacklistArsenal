private[ "_item", "_itemType", "_ret" ];

params[ "_box", "_items" ];

{
	if !( isNil "_x" ) then {

		_item = _x;

		_itemType = _item call BIS_fnc_itemType;
		if !( ( _itemType select 0 ) isEqualTo "" ) then {
			switch ( _itemType select 0 ) do {
				case "Item" : {
					_ret = [ _box, _item, false, false ] call BIS_fnc_addVirtualItemCargo;
				};
				case "Weapon" : {
					if !( ( _itemType select 1 ) isEqualTo 'VehicleWeapon' ) then {
						 _ret = [ _box, _item, false, false ] call BIS_fnc_addVirtualWeaponCargo;
					};
				};
				case "Magazine" : {
					_ret = [ _box, _item, false, false ] call BIS_fnc_addVirtualMagazineCargo;
				};
				case 'Mine' : {
					_ret = [ _box, _item, false, false ] call BIS_fnc_addVirtualMagazineCargo;
				};
				case "Equipment" : {
					if ( ( _itemType select 1 ) isEqualTo 'Backpack' ) then {
						_ret = [ _box, _item, false, false ] call BIS_fnc_addVirtualBackpackCargo;
					}else{
						_ret = [ _box, _item, false, false ] call BIS_fnc_addVirtualItemCargo;
					};
				};
			};
		};
	};

}forEach _items;