
if !( isServer ) exitWith {};

_ammoBox = _this;

JIPID =  [ _ammoBox, [ LARs_allGear ], west, "allGear" ] call LARs_fnc_blacklistArsenal;