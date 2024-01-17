export enum ERock {
  Asteroid = 1,
  Motherlode,
}

export enum EBuilding {
  MainBase = 1,

  // Mines
  LithiumMine,
  IronMine,
  CopperMine,
  SulfurMine,

  // Factories
  IronPlateFactory,
  AlloyFactory,
  PVCellFactory,
  RocketFuelFactory,

  // Utilities
  SolarPanel,

  // Units
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
}

export enum EResource {
  //Raw
  R_Titanium = 1,
  R_Platinum,
  R_Iridium,
  R_Kimberlite,

  Iron,
  Copper,
  Lithium,
  Sulfur,
  Titanium,
  Iridium,
  Kimberlite,
  Platinum,

  // Crafted Items
  IronPlate,
  Alloy,
  PVCell,
  RocketFuel,

  // Utilities
  U_Electricity,
  U_Housing,
  U_Vessel,
  U_Orders,
  U_MaxMoves,
  U_Defense,
  U_Unraidable,
  U_AdvancedUnraidable,

  // Multipliers
  M_DefenseMultiplier,
}

export enum ESize {
  Small = 1,
  Medium,
  Large,
}

export enum EUnit {
  MiningVessel = 1,
  AegisDrone,
  HammerDrone,
  StingerDrone,
  AnvilDrone,
  MinutemanMarine,
  TridentMarine,
  LightningCraft,
}

export enum ESendType {
  Reinforce = 1,
  Invade,
  Raid,
}

export enum EOrderType {
  Resource = 1,
  Unit,
}

export enum EObjectives {
  BuildIronMine = 1,
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

  CommissionMiningVessel,
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

  MineTitanium1,
  MineTitanium2,
  MineTitanium3,
  MinePlatinum1,
  MinePlatinum2,
  MinePlatinum3,
  MineIridium1,
  MineIridium2,
  MineIridium3,
  MineKimberlite1,
  MineKimberlite2,
  MineKimberlite3,

  RaidRawResources1,
  RaidRawResources2,
  RaidRawResources3,
  RaidFactoryResources1,
  RaidFactoryResources2,
  RaidFactoryResources3,
  RaidMotherlodeResources1,
  RaidMotherlodeResources2,
  RaidMotherlodeResources3,

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
}

export enum EAllianceInviteMode {
  Open = 1,
  Closed,
}

export enum EAllianceRole {
  Owner = 1, // has all access
  CanGrantRole, //can grant roles except the grant role role
  CanKick, // can invite and kick members
  CanInvite, //can only invite members
  Member, // simple member with no special access
}

export const MUDEnums = {
  ERock: enumToArray(ERock),
  EBuilding: enumToArray(EBuilding),
  EResource: enumToArray(EResource),
  ESize: enumToArray(ESize),
  EUnit: enumToArray(EUnit),
  ESendType: enumToArray(ESendType),
  EObjectives: enumToArray(EObjectives),
  EAllianceInviteMode: enumToArray(EAllianceInviteMode),
  EAllianceRole: enumToArray(EAllianceRole),
  EOrderType: enumToArray(EOrderType),
};

function enumToArray(enumObj: object): string[] {
  return ["NULL", ...Object.keys(enumObj).filter((key) => isNaN(Number(key))), "LENGTH"];
}
