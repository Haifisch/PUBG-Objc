//
//  main.m
//  PUBG
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUBG.h"

PUBG *libPUBG;

void print_seperator() {
    printf("[-----------------------------------------------------------------]\n");
}

void player_query_tests() {
    // Try getting a player by their nickname
    [libPUBG getPlayerByName:@"xxxPabloEscoxxx" withCompletion:^(Player *response) {
        if (response.foundPlayer) {
            print_seperator();
            printf("\tPlayer found by their nickname!\n");
            printf("\tPlayer name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tPlayer ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tUpdated timestamp === %s\n", [response.playerUpdateTimestamp cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\t#1 Match ID === %s\n", [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
            print_seperator();
        } else {
            printf("\tPlayer not found!\n");
        }
    }];
    
    // Try getting a player by their ID
    [libPUBG getPlayerByID:@"account.468977b890124455811b30dc7a138fcd" withCompletion:^(Player *response) {
        if (response.foundPlayer) {
            print_seperator();
            printf("\tPlayer found by their ID!\n");
            printf("\tPlayer name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tPlayer ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tUpdated timestamp === %s\n", [response.playerUpdateTimestamp cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\t#1 Match ID === %s\n", [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
            print_seperator();
        } else {
            printf("\tPlayer not found!\n");
        }
    }];
}

void match_query_tests() {
    // Retrieve a match by its ID
    __block Match *foundMatch;
    [libPUBG getMatchByID:@"a29a29b5-8835-4537-aca7-c86deb81adae" withCompletion:^(Match *response) {
        if (response.foundMatch) {
            foundMatch = response;
            print_seperator();
            printf("\tMatch found!\n");
            printf("\tMatch ID === %s\n", [response.matchID cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tMatch mode === %s\n", [response.gameMode cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tMatch duration === %i (~%d minutes)\n\n", (int)response.duration, ((int)response.duration/60));
            // Get player stats
            PlayerStats *stats = [foundMatch getStatsForPlayer:@"xxxPabloEscoxxx"];
            printf("\tStats for %s in match %s\n", [stats.playerName cStringUsingEncoding:NSUTF8StringEncoding], [foundMatch.matchID cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tTime survived === %i (~%d minutes)\n", (int)stats.timeSurvived, ((int)stats.timeSurvived/60));
            printf("\tWin place === %i/100\n", (int)stats.winPlace);
            printf("\tKill place === %i/100\n", (int)stats.killPlace);
            printf("\tKills === %i\n", (int)stats.kills);
            printf("\tAssists === %i\n", (int)stats.assists);
            printf("\tDBNOs === %i\n", (int)stats.DBNOs);
            printf("\tDamage dealt === %f\n", stats.damageDealt);
            printf("\tHeals used === %i\n", (int)stats.heals);
            printf("\tBoosts used === %i\n", (int)stats.boostsUsed);
            printf("\tDeath type === %s\n\n", [stats.deathType cStringUsingEncoding:NSUTF8StringEncoding]);
            if ([foundMatch.gameMode isEqualToString:@"squad"] || [foundMatch.gameMode isEqualToString:@"duo"]) {
                NSArray *team = [foundMatch getAllPlayersInTeamWith:@"xxxPabloEscoxxx"][1]; // Index 0 holds the IDs, 1 holds the nicknames
                printf("\tTeammates in game;\n");
                for (int i = 0; i < team.count; i++) {
                    printf("\t\t%s\n", [team[i] cStringUsingEncoding:NSUTF8StringEncoding]);
                }
            }
            print_seperator();
        } else {
            printf("\tMatch not found!\n");
        }
    }];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Enter your PUBG API key here (see https://developer.playbattlegrounds.com for more details)
        NSString *key = @"";
        
        // Init library
        libPUBG = [[PUBG alloc] initWithAPIKey:key andRegion:kPUBGRegionNA];
        
        // Get the most current version
        [libPUBG getVersionWithCompletion:^(NSDictionary *versionInfo) {
            print_seperator();
            printf("\tCurrent version === %s\n",[versionInfo[@"version"] cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tReleased === %s\n", [versionInfo[@"releasedAt"] cStringUsingEncoding:NSUTF8StringEncoding]);
            print_seperator();
        }];
        
        player_query_tests();
        match_query_tests();
        pause();
    }
    return 0;
}
