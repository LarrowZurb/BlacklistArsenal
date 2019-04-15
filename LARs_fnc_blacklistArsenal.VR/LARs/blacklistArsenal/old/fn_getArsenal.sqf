//Return list of either..
//Array of arrays [ [ names ], [ actionIDs ] ]
//or
//Array of arsenals cargo

if !( params [
	[ "_box", objNull, [ objNull ] ]
] || isNull _box ) exitWith {
	"Invalid object passed for Arsenal box"	call BIS_fnc_error;
};

_arsenal = param [ 1, "", [ "" ] ];

if ( _arsenal isEqualTo "" ) then {
	_box getVariable [ "LARs_Arsenals", [ [], [] ] ]
}else{
	_box getVariable [ format[ "LARs_Arsenal_cargo_%1", _arsenal ], [ [], [], [], [] ] ]
};