class LARs_blacklistArsenal
{
	tag = "LARs";
	class Arsenal
	{
		file = "LARs\blacklistArsenal";
		class allGear { preInit = 1; };
		class blacklistArsenal {};
		class createList {};
		class fixWeaponNames {};
		class removeBlack {};		
		class sideGear {};
		class tolower {};		
		class updateArsenal {};
	};
	class Loadouts {
		file = "LARs\blacklistArsenal\override";
		class initOverride { postInit = 1; };
		class loadInventory_whiteList {};
		class overrideVAButtonDown {};
		class overrideVATemplateOK {};
	};
};