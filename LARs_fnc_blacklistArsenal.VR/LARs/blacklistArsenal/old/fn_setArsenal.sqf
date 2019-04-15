if ( !( params [
	[ "_box", objNull, [ objNull ] ]
] ) || { isNull _box } ) exitWith {
	"Invalid object passed for Arsenal box"	call BIS_fnc_error;
	false
};

if ( !( ( _this select [ 1, 1 ] ) params[
	[ "_arsenal", "", [ "" ] ]
] ) || { _arsenal isEqualTo "" } ) exitWith {
	"No arsenal name passed to store" call BIS_fnc_error;
	false
};

_actionID = param [ 2, -1, [ 0 ] ];

private[ "_arsenals", "_index" ];

_arsenals = [ _box ] call LARs_fnc_getArsenal;

if ( _actionID > -1 ) then {
	_index = {
		if ( isNil { _x } ) exitWith { _forEachIndex };
		nil
	}forEach ( _arsenals select 0 );
	if ( isNil "_index" ) then {
		_index = ( _arsenals select 1 ) pushBack _actionID;
	}else{
		_index = ( _arsenals select 1 ) set [ _index, _actionID ];
	};
	( _arsenals select 0 ) set [ _index, _arsenal ];
}else{
	_index = ( _arsenals select 0 ) find _arsenal;
	( _arsenal select 0 ) set [ _index, nil ];
	( _arsenal select 1 ) set [ _index, nil ];
};
_box setVariable [ "LARs_Arsenals", _arsenals ];

true
