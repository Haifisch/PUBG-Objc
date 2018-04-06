# PUBG-Objc
Objective-C Library for the PUBG API

- [x] Finding a user
- [x] Grabbing the newest version info
- [x] Grabbing match data
- [ ] Parsing telemetry data

## Objective-C Library Documentation 
###### Installation
1. Simply drag and drop the source files in 'pubg_objc' into your project.
2. Alternatively, open the provided Xcode project and build the static library. Drag and drop the compiled library into your project and link against it. Be sure to copy over the associated header files as well. 

###### PUBG Class
**Region Macros**
```objc
kPUBGRegionKAKAO @"pc-kakao"
kPUBGRegionKRJP @"pc-krjp"
kPUBGRegionSEA @"pc-sea"
kPUBGRegionNA @"pc-na"
kPUBGRegionEU @"pc-eu"
kPUBGRegionOC @"pc-oc"
kPUBGRegionSA @"pc-sa"
kPUBGRegionAS @"pc-as"
```

**Methods**
```objc
// Initialize with an API key and a selected target region.
- (id)initWithAPIKey:(NSString *)key andRegion:(NSString *)region;
// Change the target region.
- (void)setRegion:(NSString *)Region;
// Get a player by their PUBG name, returns a Player object.
- (void)getPlayerByName:(NSString *)playerName withCompletion:(playerResponse)completion;
// Get a player by their PUBG identifier, returns a Player object.
- (void)getPlayerByID:(NSString *)identifier withCompletion:(playerResponse)completion;
// Get a match by its identifier, returns a Match object
- (void)getMatchByID:(NSString *)matchID withCompletion:(matchResponse)completion;
// Get the current PUBG API version info
- (void)getVersionWithCompletion:(versionDictionary)completion;
```

###### Player Class
**Properties**
```objc
// If the player was sucessfully found, will be set to 'true'.
@property (nonatomic, assign) BOOL foundPlayer;
// The player's PUBG identifier.
@property (nonatomic, assign) NSString *playerIdentifier;
// The player's PUBG nickname.
@property (nonatomic, assign) NSString *playerName;
// PUBG API update timestamp.
@property (nonatomic, assign) NSString *playerUpdateTimestamp;
// All available matches for the player, contains an array of match identifiers.
@property (nonatomic, assign) NSArray *playerMatches;
```

## PUBG CLI 
###### Available commands;

- -key "API key" -- Your API key aquired from https://developer.playbattlegrounds.com. (Required)
- -run -- Run basic tests (get user, match data, etc.)
- -findPlayer -- Find a player.
	- Arguments;
		- -playerName "player name" -- Find player by their name. *(Required)*
		- -playerIdentifier "player identifier" -- Find player by their identifier. *(Optional)*
		- -extra -- Print out all matches availble for the player. *(Optional)*
- -findMatch -- Find and print out general data for a match. 
    - Arguments;
		- -matchIdentifier "match identifier" -- Target match identifier. *(Required)*
		- -playerName "player name" -- Print out a player's stats in a match using their in-game nickname. *(Optional)*
		- -extra -- Print all teammates for player. *(Optional)*

###### Examples and Tips
Store your API Key in an envoirnment variable so you can easily reference it when running the CLI

```bash
export PUBG_API_KEY="SOME_LONG_API_KEY"
./PUBG -key $PUBG_API_KEY -findPlayer -playerName "xxxPabloEscoxxx"
```

**Get player by their name**
```bash
./PUBG -key $PUBG_API_KEY -findPlayer -playerName "xxxPabloEscoxxx"

Player found!
[-----------------------------------------------------------------]
	Player name === xxxPabloEscoxxx
	Player ident === account.468977b890124455811b30dc7a138fcd
	Date updated === Thursday, 5 April 2018 07:33:56 PM
	Available matches === 1
	#1 Match ID === edc81fee-e649-412b-a99d-1191fbe29dd6
[-----------------------------------------------------------------]
```

**Get player by their identifier and print all available matches**
```bash
./PUBG -key $PUBG_API_KEY -findPlayer -playerIdentifier "account.468977b890124455811b30dc7a138fcd" -extra

Player found!
[-----------------------------------------------------------------]
	Player name === xxxPabloEscoxxx
	Player ident === account.468977b890124455811b30dc7a138fcd
	Date updated === Thursday, 5 April 2018 07:33:56 PM
	Available matches === 1
	#1 -- edc81fee-e649-412b-a99d-1191fbe29dd6
[-----------------------------------------------------------------]
```

**Get a match by its identifier**
```bash
./PUBG -key $PUBG_API_KEY -findMatch -match "edc81fee-e649-412b-a99d-1191fbe29dd6"

Match found!
[-----------------------------------------------------------------]
	Match ID === edc81fee-e649-412b-a99d-1191fbe29dd6
	Match mode === squad
	Match duration === 1839 (~30 minutes)
	Telemetry download === https://telemetry-cdn.playbattlegrounds.com/bluehole-pubg/pc-na/2018/04/05/19/33/46594560-3908-11e8-8f50-0a586466e49f-telemetry.json
[-----------------------------------------------------------------]
```

**Get a match by its identifier, print out a players stats given their name, and print team list if applicable**
```bash
./PUBG -key $PUBG_API_KEY -findMatch -match "edc81fee-e649-412b-a99d-1191fbe29dd6" -playerName "xxxPabloEscoxxx" -extra
Match found!
[-----------------------------------------------------------------]
	Match ID === edc81fee-e649-412b-a99d-1191fbe29dd6
	Match mode === squad
	Match duration === 1839 (~30 minutes)
	Telemetry download === https://telemetry-cdn.playbattlegrounds.com/bluehole-pubg/pc-na/2018/04/05/19/33/46594560-3908-11e8-8f50-0a586466e49f-telemetry.json
[-----------------------------------------------------------------]

"xxxPabloEscoxxx" stats for match edc81fee-e649-412b-a99d-1191fbe29dd6
[-----------------------------------------------------------------]
	Time survived === 1485 (~24 minutes)
	Win place === 6/100
	Kill place === 6/100
	Kills === 4
	Assists === 1
	DBNOs === 1
	Damage dealt === 311.617340
	Heals used === 3
	Boosts used === 7
	Death type === byplayer
	Teammates;
		"Layczh" (~~~~)
		"LakeMonster" (~~~~)
		"doyalwinston" (~~~~)
		"xxxPabloEscoxxx" (account.468977b890124455811b30dc7a138fcd)
[-----------------------------------------------------------------]
```

**Run API tests**
```bash
./PUBG -key $PUBG_API_KEY -doTests
```
