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


// This probably needs some revision, seems really hacky
- (NSArray *)getAllPlayersInTeamWith:(NSString *)playerName {
    NSMutableArray *groupIDs = [[NSMutableArray alloc] init];
    NSMutableArray *groupNames = [[NSMutableArray alloc] init];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSString *playerRosterID = NULL;
    NSString *groupRosterID = NULL;
    for (int i = 0; i < self.playersInMatch.count; i++) {
        if ([self.playersInMatch[i][@"type"] isEqualToString:@"participant"] && [self.playersInMatch[i][@"attributes"][@"stats"][@"name"] isEqualToString:playerName]) {
            playerRosterID = self.playersInMatch[i][@"id"];
            break;
        }
    }
    if (playerRosterID == NULL) {
        printf("\tFailed to match an ID to the requested player name!\n");
        return NULL;
    }
    BOOL foundGroup = false;
    for (int i = 0; (i < self.playersInMatch.count) && !foundGroup; i++) {
        if ([self.playersInMatch[i][@"type"] isEqualToString:@"roster"]) {
            NSArray *currentRoster = self.playersInMatch[i][@"relationships"][@"participants"][@"data"];
            for (int b = 0; b < currentRoster.count; b++) {
                if ([currentRoster[b][@"id"] isEqualToString:playerRosterID]) {
                    groupRosterID = self.playersInMatch[i][@"id"];
                    foundGroup = true;
                    for (int z = 0; z < currentRoster.count; z++) {
                        [groupIDs addObject:currentRoster[z][@"id"]];
                    }
                    break;
                }
            }
        }
    }
    [ret addObject:[groupIDs copy]];
    for (int q = 0; q < groupIDs.count; q++) {
        for (int f = 0; f < self.playersInMatch.count; f++) {
            if ([self.playersInMatch[f][@"type"] isEqualToString:@"participant"] && [self.playersInMatch[f][@"id"] isEqual:groupIDs[q]]) {
                [groupNames addObject:self.playersInMatch[f][@"attributes"][@"stats"][@"name"]];
                break;
            }
        }
    }
    [ret addObject:[groupNames copy]];
    return ret;
}
@end
