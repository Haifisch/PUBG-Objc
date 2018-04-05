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

// Initializers
- (id)initWithAPIKey:(NSString *)key andRegion:(NSString *)region;

// Player Queries
- (void)getPlayerByName:(NSString *)playerName withCompletion:(playerResponse)completion;
- (void)getPlayerByID:(NSString *)identifier withCompletion:(playerResponse)completion;

// Match Queries
- (void)getMatchByID:(NSString *)matchID withCompletion:(matchResponse)completion;

// PUBG Version Info
- (void)getVersionWithCompletion:(versionDictionary)completion;
@end
