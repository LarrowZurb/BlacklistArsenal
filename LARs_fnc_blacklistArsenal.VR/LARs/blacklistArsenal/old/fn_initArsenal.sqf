#define EXISTS( _box, _name ) ( _name in (( [ _box ] call LARs_fnc_getArsenal ) select 0 ) )

if ( !( params [
	[ "_box", objNull, [ objNull ] ]
] ) || { isNull _box } ) exitWith {
	"Invalid object passed for Arsenal box"	call BIS_fnc_error;
	false
};
_arsenal = param[ 1, "", [ "" ] ];
//if !( ( ( _this select [ 1, 1 ] ) params[
//	[ "_arsenal", "", [ "" ] ]
//] ) || { !( _arsenal isEqualTo "" || EXISTS( _box, _arsenal ) ) } ) exitWith {
//	( [ "No arsenal name passed to init", format[ "Arsenal named %1 already exists", str _arsenal ] ] select EXISTS( _box, _arsenal ) ) call BIS_fnc_error;
//	false
//};

//( _this select [ 2, 1 ] ) params[
//	[ "_actionName", "", [ "" ] ]
//];

_arsenalCargo = format[ "LARs_Arsenal_cargo_%1", _arsenal ];


//Init local Arsenal action
_actionID = _box addAction [
	format [ "%1 - %2", localize "STR_A3_Arsenal", _arsenal ],
	compile format[ "
		_box = _this select 0;
		_unit = _this select 1;
		_box setvariable [ 'bis_addVirtualWeaponCargo_cargo', _box getvariable [ %1, [ [], [], [], [] ] ] ];
		['Open',[nil,_box]] call BIS_fnc_arsenal;
	", str _arsenalCargo ],
	[],
	6,
	true,
	false,
	"",
	format[ "
		_cargo = _target getvariable [%1,[[],[],[],[]]];
		if ({count _x > 0} count _cargo == 0) then {
			_arsenals = [ _target ] call LARs_fnc_getArsenal;
			_index = ( _arsenals select 0 ) find %2;
			_target removeaction (( _arsenals select 1 ) select _index );
			[ _target, %2 ] call LARs_fnc_setArsenal;
		};
		_condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
		alive _target && {_target distance _this < 5} && {call _condition}
	", str _arsenalCargo, str _arsenal ]
];

[ _box, _arsenal, _actionID ] call LARs_fnc_setArsenal;


true
