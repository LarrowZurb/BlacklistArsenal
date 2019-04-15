_white = [ "launch_B_Titan_short_F", "launch_I_Titan_short_F" ];
[ cursorObject, "No launchers/optics", [ _white ] ] call LARs_fnc_updateArsenal

_black = [ "launch_B_Titan_short_F", "launch_I_Titan_short_F" ];
[ cursorObject, "No launchers/optics", [ nil, _black ] ] call LARs_fnc_updateArsenal







//_virt# are bis_addVirtualWeaponCargo_cargo as placed on the object via blacklistArsenal
//_inventory# are items from a saved arsenal inventory from profileNamespace

_virtItems = (missionnamespace call bis_fnc_getVirtualItemCargo) +
(_box  call bis_fnc_getVirtualItemCargo) +
items player +
assigneditems player +
primaryweaponitems player +
secondaryweaponitems player +
handgunitems player +
[uniform player,vest player,headgear player,goggles player];
_virtWeap = [];
{
	_weapon = _x call bis_fnc_baseWeapon;
	_virtWeap set [count _virtWeap,_weapon];
	{
		private ['_item'];
		_item = gettext (_x >> 'item');
		if !(_item in _virtItems) then {_virtItems set [count _virtItems,_item];};
	} foreach ((configfile >> 'cfgweapons' >> _x >> 'linkeditems') call bis_fnc_returnchildren);
} foreach ((missionnamespace call bis_fnc_getVirtualWeaponCargo) + (_box call bis_fnc_getVirtualWeaponCargo) + weapons player + [binocular player]);
_virtMags = (missionnamespace call bis_fnc_getVirtualMagazineCargo) + (_box call bis_fnc_getVirtualMagazineCargo) + magazines player;
_virtBP = (missionnamespace call bis_fnc_getVirtualBackpackCargo) + (_box call bis_fnc_getVirtualBackpackCargo) + [backpack player];


_data = profilenamespace getvariable ['bis_fnc_saveInventory_data',[]];
_index = _data find 'ctrg';
_inventory = _data select (_index + 1);
_inventoryItems = (
	[_inventory select 0 select 0] + (_inventory select 0 select 1) +
	[_inventory select 1 select 0] + (_inventory select 1 select 1) +
	(_inventory select 2 select 1) +
	[_inventory select 3] +
	[_inventory select 4] +
	(_inventory select 6 select 1) +
	(_inventory select 7 select 1) +
	(_inventory select 8 select 1) +
	(_inventory select 9)
) - [''];
_inventoryWeapons = [
	(_inventory select 5),
	(_inventory select 6 select 0),
	(_inventory select 7 select 0),
	(_inventory select 8 select 0)
] - [''];
_inventoryMagazines = (
	(_inventory select 0 select 1) +
	(_inventory select 1 select 1) +
	(_inventory select 2 select 1)
) - [''];
_inventoryBackpacks = [_inventory select 2 select 0] - [''];

_inventoryItems = _inventoryItems arrayIntersect _inventoryItems;
_inventoryWeapons = _inventoryWeapons arrayIntersect _inventoryWeapons;
_inventoryMagazines = _inventoryMagazines arrayIntersect _inventoryMagazines;
_inventoryBackpacks = _inventoryBackpacks arrayIntersect _inventoryBackpacks;

_noMatchItems = [];
_matchItems = ( {
	_item = _x;
	if ( {
		if ( _item == _x ) exitWith {
			true
		};
		false;
	}count ( _virtItems + _virtMags )  isEqualTo 0 ) then {
		_nul = _noMatchItems pushBackUnique _item;
		false
	}else{
		true
	};
}count _inventoryItems );

_noMatchWeapons = [];
_matchWeap = ( {
	_item = _x;
	if ( {
		if ( _item == _x ) exitwith {
			true
		};
		false;
	}count _virtWeap isEqualTo 0 ) then {
		_nul = _noMatchWeapons pushBackUnique _item;
		false
	}else{
		true
	};
}count _inventoryWeapons );

_noMatchMags = [];
_matchMags = ( {
	_item = _x;
	if ( {
		if ( _item == _x ) exitwith {
			true
		};
		false;
	}count ( _virtItems + _virtMags )  isEqualTo 0 ) then {
		_nul = _noMatchMags pushBackUnique _item;
		false
	}else{
		true
	};
}count _inventoryMagazines );

_noMatchBP = [];
_matchBP = ( {
	_item = _x;
	if ( {
		if ( _item == _x ) exitwith {
			true
		};
		false;
	}count _virtBP isEqualTo 0 ) then {
		_nul = _noMatchBP pushBackUnique _item;
		false
	}else{
		true
	};
}count _inventoryBackpacks );

_msg = '';
{
	_x params [ '_numMatch', '_from', '_items' ];
	_header = [ 'ITEMS', 'WEAPONS', 'MAGS', 'BP' ] select _forEachIndex;
	_msg = _msg + _header + format[ '\n%2 outof %3\n%4\n\n', _numMatch, _from, _items];
}foreach [
	[ _matchItems, count _inventoryItems, _noMatchItems ],
	[ _matchWeap, count _inventoryWeapons, _noMatchWeapons ],
	[ _matchMags, count _inventoryMagazines, _noMatchMags ],
	[ _matchBP, count _inventoryBackpacks, _noMatchBP ]
];
copyToClipboard str [ _inventoryItems, _inventoryWeapons, _inventoryMagazines, _inventoryBackpacks ];





//_virt# are bis_addVirtualWeaponCargo_cargo as placed on the object via blacklistArsenal
//_inventory# are items from a saved arsenal inventory from profileNamespace


//CTRG - template
[
	//Items
	["U_B_CTRG_1","30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","V_PlateCarrierL_CTRG","FirstAidKit","SmokeShell","Chemlight_green","H_HelmetB_light_snakeskin","G_Tactical_Clear","muzzle_snds_H","acc_flashlight","optic_Arco","bipod_01_F_snd","muzzle_snds_L","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS"],
	//Weapons
	["Rangefinder","arifle_MX_F","hgun_P07_F"],
	//Magazines
	["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","FirstAidKit","SmokeShell","Chemlight_green"],
	//BP
	["B_Kitbag_rgr"]
]

//NoMatch
[
	//Items
	["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell","Chemlight_green","muzzle_snds_H","acc_flashlight","optic_Arco","muzzle_snds_L"],
	//Weapons
	["arifle_MX_F","hgun_P07_F"],
	//Magazines
	["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","HandGrenade","SmokeShell","Chemlight_green"],
	//BP
	["B_Kitbag_rgr"]
]

//BLA - bis_addVirtualWeaponCargo_cargo
[
	["u_b_combatuniform_mcam","u_b_combatuniform_mcam_tshirt","u_b_combatuniform_mcam_vest","u_b_ghilliesuit","u_b_helipilotcoveralls","u_b_wetsuit","u_o_combatuniform_ocamo","u_o_ghilliesuit","u_o_pilotcoveralls","u_o_wetsuit","u_c_poloshirt_blue","u_c_poloshirt_burgundy","u_c_poloshirt_stripped","u_c_poloshirt_tricolour","u_c_poloshirt_salmon","u_c_poloshirt_redwhite","u_rangemaster","u_orestesbody","u_b_combatuniform_mcam_worn","u_b_pilotcoveralls","u_o_combatuniform_oucamo","u_o_specopsuniform_ocamo","u_o_officeruniform_ocamo","u_i_combatuniform","u_i_combatuniform_shortsleeve","u_i_pilotcoveralls","u_i_helipilotcoveralls","u_i_ghilliesuit","u_i_officeruniform","u_i_wetsuit","u_competitor","u_bg_guerilla1_1","u_bg_guerilla2_1","u_bg_guerilla2_2","u_bg_guerilla2_3","u_bg_guerilla3_1","u_bg_leader","u_c_poor_1","u_c_workercoveralls","u_c_hunterbody_grn","u_b_ctrg_1","u_b_ctrg_2","u_b_ctrg_3","u_b_survival_uniform","u_i_g_story_protagonist_f","u_i_g_resistanceleader_f","u_c_journalist","u_c_scientist","u_b_protagonist_vr","u_o_protagonist_vr","u_i_protagonist_vr","u_bg_guerrilla_6_1","u_c_driver_1","u_c_driver_2","u_c_driver_3","u_c_driver_4","u_marshal","u_c_driver_1_black","u_c_driver_1_blue","u_c_driver_1_green","u_c_driver_1_red","u_c_driver_1_white","u_c_driver_1_yellow","u_c_driver_1_orange","u_b_fullghillie_lsh","u_b_fullghillie_sard","u_b_fullghillie_ard","u_o_fullghillie_lsh","u_o_fullghillie_sard","u_o_fullghillie_ard","u_i_fullghillie_lsh","u_i_fullghillie_sard","u_i_fullghillie_ard","u_b_t_soldier_f","u_b_t_soldier_ar_f","u_b_t_soldier_sl_f","u_b_t_sniper_f","u_b_t_fullghillie_tna_f","u_b_ctrg_soldier_f","u_b_ctrg_soldier_2_f","u_b_ctrg_soldier_3_f","u_b_gen_soldier_f","u_b_gen_commander_f","u_o_t_soldier_f","u_o_t_officer_f","u_o_t_sniper_f","u_o_t_fullghillie_tna_f","u_o_v_soldier_viper_f","u_o_v_soldier_viper_hex_f","u_i_c_soldier_para_1_f","u_i_c_soldier_para_2_f","u_i_c_soldier_para_3_f","u_i_c_soldier_para_4_f","u_i_c_soldier_para_5_f","u_i_c_soldier_bandit_1_f","u_i_c_soldier_bandit_2_f","u_i_c_soldier_bandit_3_f","u_i_c_soldier_bandit_4_f","u_i_c_soldier_bandit_5_f","u_i_c_soldier_camo_f","u_c_man_sport_1_f","u_c_man_sport_2_f","u_c_man_sport_3_f","u_c_man_casual_1_f","u_c_man_casual_2_f","u_c_man_casual_3_f","u_c_man_casual_4_f","u_c_man_casual_5_f","u_c_man_casual_6_f","u_b_ctrg_soldier_urb_1_f","u_b_ctrg_soldier_urb_2_f","u_b_ctrg_soldier_urb_3_f","v_rangemaster_belt","v_bandollierb_khk","v_bandollierb_cbr","v_bandollierb_rgr","v_bandollierb_blk","v_bandollierb_oli","v_platecarrier1_rgr","v_platecarrier2_rgr","v_platecarrier2_blk","v_platecarriergl_rgr","v_platecarriergl_blk","v_platecarriergl_mtp","v_platecarrier1_blk","v_platecarrierspec_rgr","v_platecarrierspec_blk","v_platecarrierspec_mtp","v_chestrig_khk","v_chestrig_rgr","v_chestrig_blk","v_chestrig_oli","v_tacvest_khk","v_tacvest_brn","v_tacvest_oli","v_tacvest_blk","v_tacvest_camo","v_tacvest_blk_police","v_tacvestir_blk","v_harnesso_brn","v_harnessogl_brn","v_harnesso_gry","v_harnessogl_gry","v_platecarrieria1_dgtl","v_platecarrieria2_dgtl","v_platecarrieriagl_dgtl","v_platecarrieriagl_oli","v_rebreatherb","v_rebreatherir","v_rebreatheria","v_platecarrier_kerry","v_platecarrierl_ctrg","v_platecarrierh_ctrg","v_i_g_resistanceleader_f","v_press_f","v_tacchestrig_grn_f","v_tacchestrig_oli_f","v_tacchestrig_cbr_f","v_platecarrier1_tna_f","v_platecarrier2_tna_f","v_platecarrierspec_tna_f","v_platecarriergl_tna_f","v_harnesso_ghex_f","v_harnessogl_ghex_f","v_bandollierb_ghex_f","v_tacvest_gen_f","v_platecarrier1_rgr_noflag_f","v_platecarrier2_rgr_noflag_f","h_helmetb","h_helmetb_camo","h_helmetb_light","h_booniehat_khk","h_booniehat_oli","h_booniehat_mcamo","h_booniehat_tan","h_booniehat_dgtl","h_booniehat_khk_hs","h_helmetspecb","h_helmetspecb_paint1","h_helmetspecb_paint2","h_helmetspecb_blk","h_helmetspecb_snakeskin","h_helmetspecb_sand","h_helmetia","h_helmetb_grass","h_helmetb_snakeskin","h_helmetb_desert","h_helmetb_black","h_helmetb_sand","h_cap_red","h_cap_blu","h_cap_oli","h_cap_headphones","h_cap_tan","h_cap_blk","h_cap_blk_cmmg","h_cap_brn_specops","h_cap_tan_specops_us","h_cap_khaki_specops_uk","h_cap_grn","h_cap_grn_bi","h_cap_blk_raven","h_cap_blk_ion","h_cap_oli_hs","h_cap_press","h_cap_usblack","h_cap_surfer","h_cap_police","h_helmetcrew_b","h_helmetcrew_o","h_helmetcrew_i","h_pilothelmetfighter_b","h_pilothelmetfighter_o","h_pilothelmetfighter_i","h_pilothelmetheli_b","h_pilothelmetheli_o","h_pilothelmetheli_i","h_crewhelmetheli_b","h_crewhelmetheli_o","h_crewhelmetheli_i","h_helmeto_ocamo","h_helmetleadero_ocamo","h_milcap_ocamo","h_milcap_mcamo","h_milcap_gry","h_milcap_dgtl","h_milcap_blue","h_helmetb_light_grass","h_helmetb_light_snakeskin","h_helmetb_light_desert","h_helmetb_light_black","h_helmetb_light_sand","h_helmeto_oucamo","h_helmetleadero_oucamo","h_helmetspeco_ocamo","h_helmetspeco_blk","h_bandanna_surfer","h_bandanna_khk","h_bandanna_khk_hs","h_bandanna_cbr","h_bandanna_sgg","h_bandanna_sand","h_bandanna_surfer_blk","h_bandanna_surfer_grn","h_bandanna_gry","h_bandanna_blu","h_bandanna_camo","h_bandanna_mcamo","h_shemag_olive","h_shemag_olive_hs","h_shemagopen_khk","h_shemagopen_tan","h_beret_blk","h_beret_02","h_beret_colonel","h_watchcap_blk","h_watchcap_cbr","h_watchcap_khk","h_watchcap_camo","h_strawhat","h_strawhat_dark","h_hat_blue","h_hat_brown","h_hat_camo","h_hat_grey","h_hat_checker","h_hat_tan","h_racinghelmet_1_f","h_racinghelmet_2_f","h_racinghelmet_3_f","h_racinghelmet_4_f","h_racinghelmet_1_black_f","h_racinghelmet_1_blue_f","h_racinghelmet_1_green_f","h_racinghelmet_1_red_f","h_racinghelmet_1_white_f","h_racinghelmet_1_yellow_f","h_racinghelmet_1_orange_f","h_cap_marshal","h_helmet_skate","h_helmetb_ti_tna_f","h_helmeto_vipersp_hex_f","h_helmeto_vipersp_ghex_f","h_helmetb_tna_f","h_helmetb_enh_tna_f","h_helmetb_light_tna_f","h_helmetspeco_ghex_f","h_helmetleadero_ghex_f","h_helmeto_ghex_f","h_helmetcrew_o_ghex_f","h_milcap_tna_f","h_milcap_ghex_f","h_booniehat_tna_f","h_beret_gen_f","h_milcap_gen_f","g_spectacles","g_spectacles_tinted","g_combat","g_lowprofile","g_shades_black","g_shades_green","g_shades_red","g_squares","g_squares_tinted","g_sport_blackwhite","g_sport_blackyellow","g_sport_greenblack","g_sport_checkered","g_sport_red","g_tactical_black","g_aviator","g_lady_blue","g_diving","g_b_diving","g_o_diving","g_i_diving","g_goggles_vr","g_balaclava_blk","g_balaclava_oli","g_balaclava_combat","g_balaclava_lowprofile","g_bandanna_blk","g_bandanna_oli","g_bandanna_khk","g_bandanna_tan","g_bandanna_beast","g_bandanna_shades","g_bandanna_sport","g_bandanna_aviator","g_shades_blue","g_sport_blackred","g_tactical_clear","g_balaclava_ti_blk_f","g_balaclava_ti_tna_f","g_balaclava_ti_g_blk_f","g_balaclava_ti_g_tna_f","g_combat_goggles_tna_f","nvgoggles","nvgoggles_opfor","nvgoggles_indep","o_nvgoggles_hex_f","o_nvgoggles_urb_f","o_nvgoggles_ghex_f","nvgoggles_tna_f","nvgogglesb_blk_f","nvgogglesb_grn_f","nvgogglesb_gry_f","binocular","rangefinder","laserdesignator","laserdesignator_02","laserdesignator_03","laserdesignator_01_khk_f","laserdesignator_02_ghex_f","itemmap","itemgps","b_uavterminal","o_uavterminal","i_uavterminal","itemradio","itemcompass","itemwatch","minedetector","firstaidkit","medikit","toolkit"],
	
	//Weapons
	["srifle_dmr_01_f","srifle_ebr_f","srifle_gm6_f","srifle_gm6_camo_f","srifle_lrr_f","srifle_lrr_camo_f","lmg_mk200_f","lmg_zafir_f","arifle_katiba_f","arifle_katiba_c_f","arifle_katiba_gl_f","arifle_mk20_f","arifle_mk20_plain_f","arifle_mk20c_f","arifle_mk20c_plain_f","arifle_mk20_gl_f","arifle_mk20_gl_plain_f","arifle_mxc_f","arifle_mx_f","arifle_mx_gl_f","arifle_mx_sw_f","arifle_mxm_f","arifle_mxc_black_f","arifle_mx_black_f","arifle_mx_gl_black_f","arifle_mx_sw_black_f","arifle_mxm_black_f","arifle_sdar_f","arifle_trg21_f","arifle_trg20_f","arifle_trg21_gl_f","hgun_pdw2000_f","smg_01_f","smg_02_f","srifle_dmr_02_f","srifle_dmr_02_camo_f","srifle_dmr_02_sniper_f","srifle_dmr_03_f","srifle_dmr_03_khaki_f","srifle_dmr_03_tan_f","srifle_dmr_03_multicam_f","srifle_dmr_03_woodland_f","srifle_dmr_04_f","srifle_dmr_04_tan_f","srifle_dmr_05_blk_f","srifle_dmr_05_hex_f","srifle_dmr_05_tan_f","srifle_dmr_06_camo_f","srifle_dmr_06_olive_f","mmg_01_hex_f","mmg_01_tan_f","mmg_02_camo_f","mmg_02_black_f","mmg_02_sand_f","arifle_mx_khk_f","arifle_mx_gl_khk_f","arifle_mx_sw_khk_f","arifle_mxc_khk_f","arifle_mxm_khk_f","srifle_lrr_tna_f","srifle_gm6_ghex_f","srifle_dmr_07_blk_f","srifle_dmr_07_hex_f","srifle_dmr_07_ghex_f","lmg_03_f","arifle_ak12_f","arifle_ak12_gl_f","arifle_akm_f","arifle_aks_f","arifle_arx_blk_f","arifle_arx_ghex_f","arifle_arx_hex_f","arifle_ctar_blk_f","arifle_ctar_hex_f","arifle_ctar_ghex_f","arifle_ctar_gl_blk_f","arifle_ctar_gl_hex_f","arifle_ctar_gl_ghex_f","arifle_ctars_blk_f","arifle_ctars_hex_f","arifle_ctars_ghex_f","arifle_spar_01_blk_f","arifle_spar_01_khk_f","arifle_spar_01_snd_f","arifle_spar_01_gl_blk_f","arifle_spar_01_gl_khk_f","arifle_spar_01_gl_snd_f","arifle_spar_02_blk_f","arifle_spar_02_khk_f","arifle_spar_02_snd_f","arifle_spar_03_blk_f","arifle_spar_03_khk_f","arifle_spar_03_snd_f","smg_05_f","launch_nlaw_f","launch_rpg32_f","launch_b_titan_f","launch_i_titan_f","launch_o_titan_f","launch_b_titan_short_f","launch_i_titan_short_f","launch_o_titan_short_f","launch_rpg32_ghex_f","launch_rpg7_f","launch_b_titan_tna_f","launch_b_titan_short_tna_f","launch_o_titan_ghex_f","launch_o_titan_short_ghex_f","hgun_acpc2_f","hgun_p07_f","hgun_pistol_heavy_01_f","hgun_pistol_heavy_02_f","hgun_rook40_f","hgun_pistol_signal_f","hgun_p07_khk_f","hgun_pistol_01_f"],
	
	//Magazines
	["handgrenade","minigrenade","smokeshell","smokeshellyellow","smokeshellred","smokeshellgreen","smokeshellpurple","smokeshellblue","smokeshellorange","chemlight_green","chemlight_red","chemlight_yellow","chemlight_blue","satchelcharge_remote_mag","iedurbanbig_remote_mag","iedlandbig_remote_mag","atmine_range_mag","apersmine_range_mag","apersboundingmine_range_mag","slamdirectionalmine_wire_mag","aperstripmine_wire_mag","claymoredirectionalmine_remote_mag","democharge_remote_mag","iedurbansmall_remote_mag","iedlandsmall_remote_mag"],
	
	//BP
	["b_assaultpack_khk","b_assaultpack_dgtl","b_assaultpack_rgr","b_assaultpack_sgg","b_assaultpack_blk","b_assaultpack_cbr","b_assaultpack_mcamo","b_assaultpack_ocamo","b_kitbag_rgr","b_kitbag_mcamo","b_kitbag_sgg","b_kitbag_cbr","b_tacticalpack_rgr","b_tacticalpack_mcamo","b_tacticalpack_ocamo","b_tacticalpack_blk","b_tacticalpack_oli","b_fieldpack_khk","b_fieldpack_ocamo","b_fieldpack_oucamo","b_fieldpack_cbr","b_fieldpack_blk","b_carryall_ocamo","b_carryall_oucamo","b_carryall_mcamo","b_carryall_khk","b_carryall_cbr","b_parachute","b_fieldpack_oli","b_carryall_oli","b_assaultpack_kerry","b_respawn_tentdome_f","b_respawn_tenta_f","b_respawn_sleeping_bag_f","b_respawn_sleeping_bag_blue_f","b_respawn_sleeping_bag_brown_f","b_hmg_01_support_f","o_hmg_01_support_f","i_hmg_01_support_f","b_hmg_01_support_high_f","o_hmg_01_support_high_f","i_hmg_01_support_high_f","b_hmg_01_weapon_f","o_hmg_01_weapon_f","i_hmg_01_weapon_f","b_hmg_01_a_weapon_f","o_hmg_01_a_weapon_f","i_hmg_01_a_weapon_f","b_gmg_01_weapon_f","o_gmg_01_weapon_f","i_gmg_01_weapon_f","b_gmg_01_a_weapon_f","o_gmg_01_a_weapon_f","i_gmg_01_a_weapon_f","b_hmg_01_high_weapon_f","o_hmg_01_high_weapon_f","i_hmg_01_high_weapon_f","b_gmg_01_high_weapon_f","o_gmg_01_high_weapon_f","i_gmg_01_high_weapon_f","b_mortar_01_support_f","o_mortar_01_support_f","i_mortar_01_support_f","b_mortar_01_weapon_f","o_mortar_01_weapon_f","i_mortar_01_weapon_f","b_aa_01_weapon_f","o_aa_01_weapon_f","i_aa_01_weapon_f","b_at_01_weapon_f","o_at_01_weapon_f","i_at_01_weapon_f","b_static_designator_01_weapon_f","o_static_designator_02_weapon_f","b_uav_01_backpack_f","o_uav_01_backpack_f","i_uav_01_backpack_f","b_bergen_mcamo_f","b_bergen_dgtl_f","b_bergen_hex_f","b_bergen_tna_f","b_assaultpack_tna_f","b_carryall_ghex_f","b_fieldpack_ghex_f","b_viperharness_blk_f","b_viperharness_ghex_f","b_viperharness_hex_f","b_viperharness_khk_f","b_viperharness_oli_f","b_viperlightharness_blk_f","b_viperlightharness_ghex_f","b_viperlightharness_hex_f","b_viperlightharness_khk_f","b_viperlightharness_oli_f"]]
	
	


["30rnd_65x39_caseless_green","16rnd_9x21_mag","6rnd_45acp_cylinder","150rnd_762x54_box","30rnd_9x21_mag_smg_02","5rnd_127x108_mag","5rnd_127x108_apds_mag","10rnd_762x54_mag","20rnd_556x45_uw_mag","30rnd_556x45_stanag_green","10rnd_127x54_mag","10rnd_93x64_dmr_05_mag","150rnd_93x64_mag","30rnd_556x45_stanag","30rnd_556x45_stanag_tracer_red","30rnd_556x45_stanag_tracer_green","30rnd_556x45_stanag_tracer_yellow","30rnd_556x45_stanag_red","9rnd_45acp_mag","200rnd_65x39_cased_box","200rnd_65x39_cased_box_tracer","30rnd_65x39_caseless_green_mag_tracer","16rnd_9x21_red_mag","16rnd_9x21_green_mag","16rnd_9x21_yellow_mag","30rnd_9x21_mag","30rnd_9x21_red_mag","30rnd_9x21_yellow_mag","30rnd_9x21_green_mag","150rnd_762x54_box_tracer","30rnd_9x21_mag_smg_02_tracer_green","30rnd_9x21_mag_smg_02_tracer_red","30rnd_9x21_mag_smg_02_tracer_yellow","20rnd_762x51_mag","30rnd_580x42_mag_f","30rnd_580x42_mag_tracer_f","100rnd_580x42_mag_f","100rnd_580x42_mag_tracer_f","20rnd_650x39_cased_mag_f","10rnd_50bw_mag_f","30rnd_65x39_caseless_mag","11rnd_45acp_mag","30rnd_45acp_mag_smg_01","100rnd_65x39_caseless_mag","7rnd_408_mag","10rnd_338_mag","130rnd_338_mag","30rnd_65x39_caseless_mag_tracer","100rnd_65x39_caseless_mag_tracer","30rnd_45acp_mag_smg_01_tracer_green","30rnd_45acp_mag_smg_01_tracer_red","30rnd_45acp_mag_smg_01_tracer_yellow","150rnd_556x45_drum_mag_f","150rnd_556x45_drum_mag_tracer_f","30rnd_762x39_mag_f","30rnd_762x39_mag_green_f","30rnd_762x39_mag_tracer_f","30rnd_762x39_mag_tracer_green_f","10rnd_9x21_mag","200rnd_556x45_box_f","200rnd_556x45_box_red_f","200rnd_556x45_box_tracer_f","200rnd_556x45_box_tracer_red_f","30rnd_545x39_mag_f","30rnd_545x39_mag_green_f","30rnd_545x39_mag_tracer_f","30rnd_545x39_mag_tracer_green_f","handgrenade","minigrenade","1rnd_smoke_grenade_shell","1rnd_smokegreen_grenade_shell","1rnd_smokered_grenade_shell","1rnd_smokeyellow_grenade_shell","1rnd_smokepurple_grenade_shell","1rnd_smokeblue_grenade_shell","1rnd_smokeorange_grenade_shell","smokeshell","smokeshellred","smokeshellgreen","smokeshellyellow","smokeshellpurple","smokeshellblue","smokeshellorange","chemlight_blue","handgrenade_stone","chemlight_green","chemlight_red","chemlight_yellow","3rnd_smoke_grenade_shell","3rnd_smokered_grenade_shell","3rnd_smokegreen_grenade_shell","3rnd_smokeyellow_grenade_shell","3rnd_smokepurple_grenade_shell","3rnd_smokeblue_grenade_shell","3rnd_smokeorange_grenade_shell","atmine_range_mag","apersmine_range_mag","apersboundingmine_range_mag","slamdirectionalmine_wire_mag","aperstripmine_wire_mag","claymoredirectionalmine_remote_mag","democharge_remote_mag","satchelcharge_remote_mag","iedurbansmall_remote_mag","iedlandsmall_remote_mag","iedurbanbig_remote_mag","iedlandbig_remote_mag","30rnd_65x39_caseless_green","16rnd_9x21_mag","6rnd_45acp_cylinder","150rnd_762x54_box","30rnd_9x21_mag_smg_02","5rnd_127x108_mag","5rnd_127x108_apds_mag","10rnd_762x54_mag","20rnd_556x45_uw_mag","30rnd_556x45_stanag_green","10rnd_127x54_mag","10rnd_93x64_dmr_05_mag","150rnd_93x64_mag","30rnd_556x45_stanag","30rnd_556x45_stanag_tracer_red","30rnd_556x45_stanag_tracer_green","30rnd_556x45_stanag_tracer_yellow","30rnd_556x45_stanag_red","9rnd_45acp_mag","200rnd_65x39_cased_box","200rnd_65x39_cased_box_tracer","30rnd_65x39_caseless_green_mag_tracer","16rnd_9x21_red_mag","16rnd_9x21_green_mag","16rnd_9x21_yellow_mag","30rnd_9x21_mag","30rnd_9x21_red_mag","30rnd_9x21_yellow_mag","30rnd_9x21_green_mag","150rnd_762x54_box_tracer","30rnd_9x21_mag_smg_02_tracer_green","30rnd_9x21_mag_smg_02_tracer_red","30rnd_9x21_mag_smg_02_tracer_yellow","20rnd_762x51_mag","30rnd_580x42_mag_f","30rnd_580x42_mag_tracer_f","100rnd_580x42_mag_f","100rnd_580x42_mag_tracer_f","20rnd_650x39_cased_mag_f","10rnd_50bw_mag_f","30rnd_65x39_caseless_mag","11rnd_45acp_mag","30rnd_45acp_mag_smg_01","100rnd_65x39_caseless_mag","7rnd_408_mag","10rnd_338_mag","130rnd_338_mag","30rnd_65x39_caseless_mag_tracer","100rnd_65x39_caseless_mag_tracer","30rnd_45acp_mag_smg_01_tracer_green","30rnd_45acp_mag_smg_01_tracer_red","30rnd_45acp_mag_smg_01_tracer_yellow","150rnd_556x45_drum_mag_f","150rnd_556x45_drum_mag_tracer_f","30rnd_762x39_mag_f","30rnd_762x39_mag_green_f","30rnd_762x39_mag_tracer_f","30rnd_762x39_mag_tracer_green_f","10rnd_9x21_mag","200rnd_556x45_box_f","200rnd_556x45_box_red_f","200rnd_556x45_box_tracer_f","200rnd_556x45_box_tracer_red_f","30rnd_545x39_mag_f","30rnd_545x39_mag_green_f","30rnd_545x39_mag_tracer_f","30rnd_545x39_mag_tracer_green_f","handgrenade","minigrenade","1rnd_smoke_grenade_shell","1rnd_smokegreen_grenade_shell","1rnd_smokered_grenade_shell","1rnd_smokeyellow_grenade_shell","1rnd_smokepurple_grenade_shell","1rnd_smokeblue_grenade_shell","1rnd_smokeorange_grenade_shell","smokeshell","smokeshellred","smokeshellgreen","smokeshellyellow","smokeshellpurple","smokeshellblue","smokeshellorange","chemlight_blue","handgrenade_stone","chemlight_green","chemlight_red","chemlight_yellow","3rnd_smoke_grenade_shell","3rnd_smokered_grenade_shell","3rnd_smokegreen_grenade_shell","3rnd_smokeyellow_grenade_shell","3rnd_smokepurple_grenade_shell","3rnd_smokeblue_grenade_shell","3rnd_smokeorange_grenade_shell","atmine_range_mag","apersmine_range_mag","apersboundingmine_range_mag","slamdirectionalmine_wire_mag","aperstripmine_wire_mag","claymoredirectionalmine_remote_mag","democharge_remote_mag","satchelcharge_remote_mag","iedurbansmall_remote_mag","iedlandsmall_remote_mag","iedurbanbig_remote_mag","iedlandbig_remote_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","Chemlight_green","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","16Rnd_9x21_Mag","SmokeShell","SmokeShellGreen","Chemlight_green","HandGrenade","HandGrenade"]



magazines[] = {"1Rnd_HE_Grenade_shell","UGL_FlareWhite_F","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareYellow_F","UGL_FlareCIR_F","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","3Rnd_HE_Grenade_shell","3Rnd_UGL_FlareWhite_F","3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareYellow_F","3Rnd_UGL_FlareCIR_F","3Rnd_Smoke_Grenade_shell","3Rnd_SmokeRed_Grenade_shell","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell"};