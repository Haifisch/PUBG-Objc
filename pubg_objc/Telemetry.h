//
//  Telemetry.h
//  Telemetry
//
//  Created by Pablo Esco on 4/7/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>

// Events
#define kPUBG_LogPlayerLogin @"LogPlayerLogin"
#define kPUBG_LogPlayerCreate @"LogPlayerCreate"
#define kPUBG_LogPlayerPosition @"LogPlayerPosition"
#define kPUBG_LogPlayerAttack @"LogPlayerAttack"
#define kPUBG_LogItemPickup @"LogItemPickup"
#define kPUBG_LogItemEquip @"LogItemEquip"
#define kPUBG_LogItemUnequip @"LogItemUnequip"
#define kPUBG_LogVehicleRide @"LogVehicleRide"
#define kPUBG_LogMatchDefinition @"LogMatchDefinition"
#define kPUBG_LogMatchStart @"LogMatchStart"
#define kPUBG_LogGameStatePeriodic @"LogGameStatePeriodic"
#define kPUBG_LogVehicleLeave @"LogVehicleLeave"
#define kPUBG_LogPlayerTakeDamage @"LogPlayerTakeDamage"
#define kPUBG_LogPlayerLogout @"LogPlayerLogout"
#define kPUBG_LogItemAttach @"LogItemAttach"
#define kPUBG_LogItemDrop @"LogItemDrop"
#define kPUBG_LogPlayerKill @"LogPlayerKill"
#define kPUBG_LogItemDetach @"LogItemDetach"
#define kPUBG_LogItemUse @"LogItemUse"
#define kPUBG_LogCarePackageSpawn @"LogCarePackageSpawn"
#define kPUBG_LogVehicleDestroy @"LogVehicleDestroy"
#define kPUBG_LogCarePackageLand @"LogCarePackageLand"
#define kPUBG_LogMatchEnd @"LogMatchEnd"

// Consumables
#define kPUBG_Item_Heal_MedKit_C @"Item_Heal_MedKit_C"
#define kPUBG_Item_Heal_FirstAid_C @"Item_Heal_FirstAid_C"
#define kPUBG_Item_Heal_Bandage_C @"Item_Heal_Bandage_C"
#define kPUBG_Item_Boost_AdrenalineSyringe_C @"Item_Boost_AdrenalineSyringe_C"
#define kPUBG_Item_Boost_PainKiller_C @"Item_Boost_PainKiller_C"
#define kPUBG_Item_Boost_EnergyDrink_C @"Item_Boost_EnergyDrink_C"
#define kPUBG_Item_JerryCan_C @"Item_JerryCan_C"

// Item common names
#define kPUBG_Item_Names @{@"Item_Weapon_M24_C":@"M24",\
@"Item_Weapon_Crossbow_C":@"Crossbow",\
@"Item_Attach_Weapon_Lower_AngledForeGrip_C":@"Angled Foregrip",\
@"Item_Attach_Weapon_Stock_AR_Composite_C":@"Tactical Stock",\
@"Item_Weapon_Sawnoff_C":@"Sawed-off",\
@"Item_Weapon_Cowbar_C":@"Crowbar",\
@"Item_Attach_Weapon_Muzzle_Compensator_SniperRifle_C":@"Sniper Rifle Compensator",\
@"Item_Weapon_M16A4_C":@"M16A4",\
@"Item_Attach_Weapon_Muzzle_FlashHider_Medium_C":@"Medium Flash Hider",\
@"Item_Weapon_Machete_C":@"Machete",\
@"Item_Attach_Weapon_Stock_SniperRifle_CheekPad_C":@"Sniper Rifle Cheek Pad",\
@"Item_Weapon_Grenade_C":@"Frag Grenade",\
@"Item_Attach_Weapon_Muzzle_Suppressor_Medium_C":@"Medium Supressor",\
@"Item_Weapon_NagantM1895_C":@"R1895",\
@"Item_Attach_Weapon_Muzzle_Suppressor_Small_C":@"Small Supressor",\
@"Item_Heal_MedKit_C":@"Med kit",\
@"Item_Weapon_M1911_C":@"P1911",\
@"Item_Attach_Weapon_Muzzle_FlashHider_SniperRifle_C":@"Sniper Rifle Flash Hider",\
@"Item_Head_E_02_Lv1_C":@"Motorcycle Helmet (Level 1)",\
@"Item_Weapon_AWM_C":@"AWM",\
@"Item_Head_F_01_Lv2_C":@"Military Helmet (Level 2)",\
@"Item_Weapon_SCAR-L_C":@"SCAR-L",\
@"Item_Attach_Weapon_Stock_UZI_C":@"Uzi Stock",\
@"Item_Attach_Weapon_Upper_CQBSS_C":@"8x CQBSS Scope",\
@"Item_Attach_Weapon_Muzzle_FlashHider_Large_C":@"Large Flash Hider",\
@"Item_Attach_Weapon_Magazine_ExtendedQuickDraw_Medium_C":@"Medium Extended QuickDraw Mag",\
@"Item_Attach_Weapon_Magazine_Extended_Large_C":@"Large Extended Mag",\
@"Item_Attach_Weapon_Muzzle_Suppressor_SniperRifle_C":@"Sniper Rifle Supressor",\
@"Item_JerryCan_C":@"Gas Can",\
@"Item_Weapon_SKS_C":@"SKS",\
@"Item_Weapon_G18_C":@"P18C",\
@"Item_Weapon_Vector_C":@"Vector",\
@"Item_Boost_AdrenalineSyringe_C":@"Adrenaline Syringe",\
@"Item_Attach_Weapon_Magazine_QuickDraw_SniperRifle_C":@"Sniper Rifle Quickdraw Mag",\
@"Item_Attach_Weapon_Magazine_QuickDraw_Medium_C":@"Medium Quickdraw Mag",\
@"Item_Ammo_300Magnum_C":@"300 Magnum Ammo",\
@"Item_Ghillie_02_C":@"Ghillie Suit",\
@"Item_Attach_Weapon_Stock_SniperRifle_BulletLoops_C":@"Sniper Rifle Bullet Loops",\
@"Item_Back_E_02_Lv1_C":@"Backpack (Level 1)",\
@"Item_Weapon_SmokeBomb_C":@"Smoke Genade",\
@"Item_Attach_Weapon_Magazine_Extended_Small_C":@"Small Extended Mag",\
@"Item_Back_C_01_Lv3_C":@"Backpack (Level 3)",\
@"Item_Back_F_01_Lv2_C":@"Backpack (Level 2)",\
@"Item_Weapon_M249_C":@"M249",\
@"Item_Weapon_Berreta686_C":@"S686",\
@"Item_Weapon_Kar98k_C":@"Kar98k",\
@"Item_Weapon_UZI_C":@"Micro Uzi",\
@"Item_Weapon_Win1894_C":@"Win94",\
@"Item_Weapon_Winchester_C":@"S1897",\
@"Item_Attach_Weapon_Magazine_ExtendedQuickDraw_SniperRifle_C":@"Sniper Rifle Extended QuickDraw Mag",\
@"Item_Weapon_Groza_C":@"Groza",\
@"Item_Head_F_02_Lv2_C":@"Military Helmet (Level 2)",\
@"Item_Ghillie_01_C":@"Ghillie Suit",\
@"Item_Head_G_01_Lv3_C":@"Spetsnaz Helmet (Level 3)",\
@"Item_Heal_FirstAid_C":@"First Aid Kit",\
@"Item_Weapon_UMP_C":@"UMP9",\
@"Item_Armor_C_01_Lv3_C":@"Military Vest (Level 3)",\
@"Item_Weapon_HK416_C":@"M416",\
@"Item_Weapon_Molotov_C":@"Molotov Cocktail",\
@"Item_Weapon_Rhino_C":@"R45",\
@"Item_Ammo_762mm_C":@"7.62mm Ammo",\
@"Item_Attach_Weapon_Upper_PM2_01_C":@"15x PM II Scope",\
@"Item_Weapon_FlashBang_C":@"Flashbang",\
@"Item_Weapon_VSS_C":@"VSS",\
@"Item_Ammo_9mm_C":@"9mm Ammo",\
@"Item_Attach_Weapon_Upper_Holosight_C":@"Holographic Sight",\
@"Item_Attach_Weapon_Muzzle_Compensator_Large_C":@"Large Compensator",\
@"Item_Attach_Weapon_Magazine_ExtendedQuickDraw_Small_C":@"Small Extended QuickDraw Mag",\
@"Item_Attach_Weapon_Lower_Foregrip_C":@"Vertical Foregrip",\
@"Item_Armor_E_01_Lv1_C":@"Police Vest (Level 1)",\
@"Item_Back_C_02_Lv3_C":@"Backpack (Level 3)",\
@"Item_Back_F_02_Lv2_C":@"Backpack (Level 2)",\
@"Item_Weapon_AUG_C":@"AUG A3",\
@"Item_Ammo_45ACP_C":@".45 ACP Ammo",\
@"Item_Attach_Weapon_Upper_ACOG_01_C":@"4x ACOG Scope",\
@"Item_Attach_Weapon_Upper_Aimpoint_C":@"2x Aimpoint Scope",\
@"Item_Back_B_01_StartParachutePack_C":@"Parachute",\
@"Item_Weapon_AK47_C":@"AKM",\
@"Item_Attach_Weapon_Upper_DotSight_01_C":@"Red Dot Sight",\
@"Item_Ammo_Bolt_C":@"Crossbow Bolt",\
@"Item_Attach_Weapon_Magazine_Extended_Medium_C":@"Medium Extended Mag",\
@"Item_Boost_PainKiller_C":@"Painkiller",\
@"Item_Weapon_DP28_C":@"DP-28",\
@"Item_Weapon_Mk14_C":@"Mk14 EBR",\
@"Item_Weapon_Thompson_C":@"Tommy Gun",\
@"Item_Weapon_Pan_C":@"Pan",\
@"Item_Attach_Weapon_Muzzle_Compensator_Medium_C":@"Medium Compensator",\
@"Item_Weapon_Mini14_C":@"Mini 14",\
@"Item_Attach_Weapon_Lower_QuickDraw_Large_Crossbow_C":@"QuickDraw Crossbow Quiver",\
@"Item_Ammo_556mm_C":@"5.56mm Ammo",\
@"Item_Attach_Weapon_Magazine_Extended_SniperRifle_C":@"Sniper Rifle Extended Mag",\
@"Item_Head_E_01_Lv1_C":@"Motorcycle Helmet (Level 1)",\
@"Item_Weapon_M9_C":@"P92",\
@"Item_Ammo_12Guage_C":@"12 Gauge Ammo",\
@"Item_Boost_EnergyDrink_C":@"Energy Drink",\
@"Item_Attach_Weapon_Magazine_ExtendedQuickDraw_Large_C":@"Large Extended QuickDraw Mag",\
@"Item_Weapon_Sickle_C":@"Sickle",\
@"Item_Attach_Weapon_Muzzle_Choke_C":@"Choke",\
@"Item_Weapon_Saiga12_C":@"S12K",\
@"Item_Heal_Bandage_C":@"Bandage",\
@"Item_Attach_Weapon_Magazine_QuickDraw_Small_C":@"Small Quickdraw Mag",\
@"Item_Attach_Weapon_Stock_Shotgun_BulletLoops_C":@"Shotgun Bullet Loops",\
@"Item_Back_E_01_Lv1_C":@"Backpack (Level 1)",\
@"Item_Attach_Weapon_Muzzle_Suppressor_Large_C":@"Large Supressor",\
@"Item_Attach_Weapon_Magazine_QuickDraw_Large_C":@"Large QuickDraw Mag",\
@"Item_Armor_D_01_Lv2_C":@"Police Vest (Level 2)"}

#define kPUBG_Damage_Causer_Names @{@"BP_PickupTruck_A_02_C":@"Pickup Truck",\
@"WeapSickle_C":@"Sickle",\
@"WeapWinchester_C":@"S1897",\
@"WeapAUG_C":@"AUG A3",\
@"WeapSaiga12_C":@"S12K",\
@"PlayerFemale_A_C":@"Player",\
@"WeapSKS_C":@"SKS",\
@"WeapThompson_C":@"Tommy Gun",\
@"BP_PickupTruck_B_02_C":@"Pickup Truck",\
@"WeapRhino_C":@"R45",\
@"Uaz_A_01_C":@"UAZ",\
@"WeapWin94_C":@"Win94",\
@"Buff_DecreaseBreathInApnea_C":@"Drowning",\
@"WeapDP28_C":@"DP-28",\
@"WeapVSS_C":@"VSS",\
@"BP_PickupTruck_A_03_C":@"Pickup Truck",\
@"BP_Motorbike_04_Desert_C":@"Motorcycle",\
@"Dacia_A_04_v2_C":@"Dacia",\
@"WeapHK416_C":@"M416",\
@"WeapM9_C":@"P92",\
@"BP_PickupTruck_B_03_C":@"Pickup Truck",\
@"WeapSCAR-L_C":@"SCAR-L",\
@"WeapMachete_C":@"Machete",\
@"Buggy_A_02_C":@"Buggy",\
@"Buggy_A_05_C":@"Buggy",\
@"WeapAWM_C":@"AWM",\
@"BP_PickupTruck_A_04_C":@"Pickup Truck",\
@"BP_Motorbike_04_C":@"Motorcycle",\
@"BP_Motorbike_04_SideCar_C":@"Motorcycle w/ Sidecar",\
@"Uaz_B_01_C":@"UAZ",\
@"WeapCowbar_C":@"Crowbar",\
@"BP_PickupTruck_B_04_C":@"Pickup Truck",\
@"WeapM249_C":@"M249",\
@"WeapM24_C":@"M24",\
@"BP_Van_A_02_C":@"Van",\
@"WeapBerreta686_C":@"S686",\
@"WeapNagantM1895_C":@"R1895",\
@"Dacia_A_03_v2_C":@"Dacia",\
@"BP_PickupTruck_A_05_C":@"Pickup Truck",\
@"WeapPan_C":@"Pan",\
@"WeapVector_C":@"Vector",\
@"WeapM16A4_C":@"M16A4",\
@"Boat_PG117_C":@"PG-117",\
@"WeapUMP_C":@"UMP9",\
@"BP_PickupTruck_B_05_C":@"Pickup Truck",\
@"WeapGroza_C":@"Groza",\
@"WeapKar98k_C":@"Kar98k",\
@"Uaz_C_01_C":@"UAZ",\
@"WeapM1911_C":@"P1911",\
@"ProjMolotov_DamageField_C":@"",\
@"WeapG18_C":@"P18C",\
@"Buggy_A_03_C":@"Buggy",\
@"Buggy_A_06_C":@"Buggy",\
@"ProjMolotov_C":@"Molotov Cocktail",\
@"WeapMk14_C":@"Mk14 EBR",\
@"RedZoneBomb_C":@"Redzone",\
@"Dacia_A_02_v2_C":@"Dacia",\
@"WeapSawnoff_C":@"Sawed-off",\
@"BattleRoyaleModeController_Desert_C":@"Bluezone",\
@"BP_Van_A_01_C":@"Van",\
@"WeapUZI_C":@"Micro Uzi",\
@"BP_PickupTruck_A_01_C":@"Pickup Truck",\
@"ProjGrenade_C":@"Grenade",\
@"ProjMolotov_DamageFieldInWall_C":@"",\
@"Buggy_A_01_C":@"Buggy",\
@"BP_Motorbike_04_SideCar_Desert_C":@"Motorcycle w/ Sidecar",\
@"Buff_FireDOT_C":@"Burning",\
@"BP_PickupTruck_B_01_C":@"Pickup Truck",\
@"Buggy_A_04_C":@"Buggy",\
@"Dacia_A_01_v2_C":@"Dacia",\
@"WeapAK47_C":@"AKM",\
@"WeapCrossbow_1_C":@"Crossbow",\
@"WeapMini14_C":@"Mini 14",\
@"BattleRoyaleModeController_Def_C":@"Bluezone",\
@"BP_Van_A_03_C":@"Van",\
@"PlayerMale_A_C":@"Player"}

@interface Telemetry_Player_Killed : NSObject
@property (nonatomic, assign) NSString *damageCauserName;
@property (nonatomic, assign) NSString *damageTypeCategory;
@property (nonatomic, assign) NSString *distance;
@property (nonatomic, assign) NSString *killerName;
@property (nonatomic, assign) NSString *killerRanking;
@property (nonatomic, assign) NSString *victumName;
@property (nonatomic, assign) NSString *victumRanking;
@end

@interface Telemetry : NSObject

// Telemetry data holder
@property (nonatomic, assign) NSArray *telemetryData;

// Completion types
typedef void(^telemetryCompletion)(NSDictionary*);

- (NSDate *)epoch;
- (NSDate *)matchStart;
- (NSDate *)matchEnd;


// Parse in NSArray from read JSON file
- (void)parseTelemetryWithCompletion:(telemetryCompletion)completion;
- (NSArray *)allEventsForType:(NSString *)eventType;

// General statistics
- (int)numberOfUses:(NSString *)itemId;

@end
