//
//  Match.m
//  pubg_objc
//
//  Created by Pablo Esco on 4/4/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import "Match.h"

@implementation Match

- (PlayerStats *)getStatsForPlayer:(NSString *)playerName {
    PlayerStats *stats = [[PlayerStats alloc] init];
    for (int i = 0; i < self.playersInMatch.count; i++) {
        if ([self.playersInMatch[i][@"type"] isEqualToString:@"participant"] && [self.playersInMatch[i][@"attributes"][@"stats"][@"name"] isEqualToString:playerName]) {
            stats.playerName = playerName;
            stats.DBNOs = [self.playersInMatch[i][@"attributes"][@"stats"][@"DBNOs"] integerValue];
            stats.assists = [self.playersInMatch[i][@"attributes"][@"stats"][@"assists"] integerValue];
            stats.boostsUsed = [self.playersInMatch[i][@"attributes"][@"stats"][@"boosts"] integerValue];
            stats.heals = [self.playersInMatch[i][@"attributes"][@"stats"][@"heals"] integerValue];
            stats.killPlace = [self.playersInMatch[i][@"attributes"][@"stats"][@"killPlace"] integerValue];
            stats.killPoints = [self.playersInMatch[i][@"attributes"][@"stats"][@"killPoints"] integerValue];
            stats.kills = [self.playersInMatch[i][@"attributes"][@"stats"][@"kills"] integerValue];
            stats.timeSurvived = [self.playersInMatch[i][@"attributes"][@"stats"][@"timeSurvived"] integerValue];
            stats.winPlace = [self.playersInMatch[i][@"attributes"][@"stats"][@"winPlace"] integerValue];
            stats.winPoints = [self.playersInMatch[i][@"attributes"][@"stats"][@"winPoints"] integerValue];
            stats.walkDistance = [self.playersInMatch[i][@"attributes"][@"stats"][@"walkDistance"] doubleValue];
            stats.damageDealt = [self.playersInMatch[i][@"attributes"][@"stats"][@"damageDealt"] doubleValue];
            stats.deathType = self.playersInMatch[i][@"attributes"][@"stats"][@"deathType"];
        }
    }
    return stats;
}

@end
