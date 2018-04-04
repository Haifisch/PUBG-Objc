//
//  pubg_objc.h
//  pubg_objc
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

// PC Regions
#define kPUBGRegionKAKAO @"pc-kakao"
#define kPUBGRegionKRJP @"pc-krjp"
#define kPUBGRegionSEA @"pc-sea"
#define kPUBGRegionNA @"pc-na"
#define kPUBGRegionEU @"pc-eu"
#define kPUBGRegionOC @"pc-oc"
#define kPUBGRegionSA @"pc-sa"
#define kPUBGRegionAS @"pc-as"

@interface pubg_objc : NSObject

// Initializers
- (id)initWithAPIKey:(NSString *)key andRegion:(NSString *)region;

// HTTP Requests
typedef void(^httpResponse)(NSDictionary *);

// Player Queries
typedef void(^playerResponse)(Player *);
- (void)getPlayerByName:(NSString *)playerName withCompletion:(playerResponse)completion;
- (void)getPlayerByID:(NSString *)identifier withCompletion:(playerResponse)completion;

@end
