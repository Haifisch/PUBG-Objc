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
            printf("\tPlayer not found!");
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
            printf("\tPlayer not found!");
        }
    }];
}

void match_query_tests() {
    // Retrieve a match by its ID
    [libPUBG getMatchByID:@"c78af09f-91b1-417a-b433-0520e5768e7b" withCompletion:^(Match *response) {
        print_seperator();
        printf("\tMatch found!\n");
        printf("\tMatch ID === %s\n", [response.matchID cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("\tMatch mode === %s\n", [response.gameMode cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("\tMatch duration === %i (~%d minutes)\n", (int)response.duration, ((int)response.duration/60));
        print_seperator();
        PlayerStats *stats = [response getStatsForPlayer:@"xxxPabloEscoxxx"];
        print_seperator();
        printf("\tStats for %s in match %s\n", [stats.playerName cStringUsingEncoding:NSUTF8StringEncoding], [response.matchID cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("\tTime survived === %i\n", (int)stats.timeSurvived);
        printf("\tWin place === %i/100\n", (int)stats.winPlace);
        printf("\tKill place === %i/100\n", (int)stats.killPlace);
        printf("\tKills === %i\n", (int)stats.kills);
        printf("\tAssists === %i\n", (int)stats.assists);
        printf("\tDBNOs === %i\n", (int)stats.DBNOs);
        printf("\tDamage dealt === %f\n", stats.damageDealt);
        printf("\tHeals used === %i\n", (int)stats.heals);
        printf("\tBoosts used === %i\n", (int)stats.boostsUsed);
        printf("\tDeath type === %s\n", [stats.deathType cStringUsingEncoding:NSUTF8StringEncoding]);
        print_seperator();
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
