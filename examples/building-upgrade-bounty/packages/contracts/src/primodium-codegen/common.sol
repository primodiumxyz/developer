// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */
enum EBuilding {
  NULL,
  MainBase,
  LithiumMine,
  IronMine,
  CopperMine,
  KimberliteMine,
  IridiumMine,
  TitaniumMine,
  PlatinumMine,
  IronPlateFactory,
  AlloyFactory,
  PVCellFactory,
  RocketFuelFactory,
  SolarPanel,
  Hangar,
  Garage,
  StorageUnit,
  Workshop,
  DroneFactory,
  Starmapper,
  SAM,
  ShieldGenerator,
  Vault,
  Market,
  Shipyard,
  LENGTH
}

enum EResource {
  NULL,
  Iron,
  Copper,
  Lithium,
  Titanium,
  Iridium,
  Kimberlite,
  Platinum,
  IronPlate,
  Alloy,
  PVCell,
  RocketFuel,
  U_Electricity,
  U_Housing,
  U_CapitalShipCapacity,
  U_MaxMoves,
  U_Defense,
  U_Unraidable,
  U_AdvancedUnraidable,
  R_HP,
  R_Encryption,
  M_DefenseMultiplier,
  LENGTH
}

enum ESize {
  NULL,
  Small,
  Medium,
  Large,
  LENGTH
}

enum EUnit {
  NULL,
  AegisDrone,
  AnvilDrone,
  StingerDrone,
  HammerDrone,
  MinutemanMarine,
  TridentMarine,
  LightningCraft,
  CapitalShip,
  Droid,
  LENGTH
}

enum ESendType {
  NULL,
  Reinforce,
  Invade,
  Raid,
  Recall,
  LENGTH
}

enum EObjectives {
  NULL,
  BuildIronMine,
  BuildCopperMine,
  BuildGarage,
  DefeatPirateBase1,
  BuildWorkshop,
  UpgradeMainBase,
  DefeatPirateBase2,
  DefeatPirateBase3,
  DefeatPirateBase4,
  DefeatPirateBase5,
  DefeatPirateBase6,
  DefeatPirateBase7,
  DefeatPirateBase8,
  DefeatPirateBase9,
  DefeatPirateBase10,
  DefeatPirateBase11,
  DefeatPirateBase12,
  DefeatPirateBase13,
  DefeatPirateBase14,
  DefeatPirateBase15,
  DefeatPirateBase16,
  DefeatPirateBase17,
  BuildLithiumMine,
  BuildIronPlateFactory,
  BuildHangar,
  BuildPVCellFactory,
  BuildSolarPanel,
  BuildDroneFactory,
  BuildStarmapper,
  BuildSAMLauncher,
  BuildVault,
  BuildShieldGenerator,
  TrainMinutemanMarine1,
  TrainMinutemanMarine2,
  TrainMinutemanMarine3,
  TrainTridentMarine1,
  TrainTridentMarine2,
  TrainTridentMarine3,
  TrainAnvilDrone1,
  TrainAnvilDrone2,
  TrainAnvilDrone3,
  TrainHammerDrone1,
  TrainHammerDrone2,
  TrainHammerDrone3,
  TrainAegisDrone1,
  TrainAegisDrone2,
  TrainAegisDrone3,
  TrainStingerDrone1,
  TrainStingerDrone2,
  TrainStingerDrone3,
  RaidRawResources1,
  RaidRawResources2,
  RaidRawResources3,
  RaidFactoryResources1,
  RaidFactoryResources2,
  RaidFactoryResources3,
  DestroyEnemyUnits1,
  DestroyEnemyUnits2,
  DestroyEnemyUnits3,
  DestroyEnemyUnits4,
  DestroyEnemyUnits5,
  ExpandBase1,
  ExpandBase2,
  ExpandBase3,
  ExpandBase4,
  ExpandBase5,
  ExpandBase6,
  LENGTH
}

enum EAllianceInviteMode {
  NULL,
  Open,
  Closed,
  LENGTH
}

enum EAllianceRole {
  NULL,
  Owner,
  CanGrantRole,
  CanKick,
  CanInvite,
  Member,
  LENGTH
}

enum EOrderType {
  NULL,
  Resource,
  Unit,
  LENGTH
}

enum EFleetKey {
  NULL,
  OwnedBy,
  Incoming,
  LENGTH
}

enum EFleetStance {
  NULL,
  Follow,
  Defend,
  Block,
  LENGTH
}
