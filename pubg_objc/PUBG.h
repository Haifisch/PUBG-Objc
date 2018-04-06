//
//  pubg_objc.h
//  pubg_objc
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Match.h"
#import "Telemetry.h"

// PC Regions
#define kPUBGRegionKAKAO @"pc-kakao"
#define kPUBGRegionKRJP @"pc-krjp"
#define kPUBGRegionSEA @"pc-sea"
#define kPUBGRegionNA @"pc-na"
#define kPUBGRegionEU @"pc-eu"
#define kPUBGRegionOC @"pc-oc"
#define kPUBGRegionSA @"pc-sa"
#define kPUBGRegionAS @"pc-as"

@interface PUBG : NSObject

@property (nonatomic, assign) NSString *Region;

// Completions
typedef void(^versionDictionary)(NSDictionary *);
typedef void(^httpResponse)(NSDictionary *);
typedef void(^playerResponse)(Player *);
typedef void(^matchResponse)(Match *);

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
@end
