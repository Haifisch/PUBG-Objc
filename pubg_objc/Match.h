//
//  Match.h
//  pubg_objc
//
//  Created by Pablo Esco on 4/4/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerStats.h"
@interface Match : NSObject

@property (nonatomic, assign) BOOL foundMatch;
@property (nonatomic, assign) NSString *matchID;
@property (nonatomic, assign) NSString *gameMode;
@property (nonatomic, assign) NSString *timestamp;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSArray *playersInMatch;

// Player stats in match 
- (PlayerStats *)getStatsForPlayer:(NSString *)playerName;
- (NSArray *)getAllPlayersInTeamWith:(NSString *)playerName;

@end
