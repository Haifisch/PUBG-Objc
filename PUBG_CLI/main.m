//
//  main.m
//  PUBG
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pubg_objc.h"

void print_seperator() {
    printf("[--------------------------------------------------------]\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Enter your PUBG API key here (see https://developer.playbattlegrounds.com for more details)
        NSString *key = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJkZDBkYmU1MC0xOGUzLTAxMzYtOTYwOC02MWFjOTE3MDJiMmEiLCJpc3MiOiJnYW1lbG9ja2VyIiwiaWF0IjoxNTIyNzAxNTY4LCJwdWIiOiJibHVlaG9sZSIsInRpdGxlIjoicHViZyIsImFwcCI6InBhYmxvcy1wdWJnIiwic2NvcGUiOiJjb21tdW5pdHkiLCJsaW1pdCI6MTB9.yn6V89y_7g8Z3K-VfpXd1jkEgPCwCRHVbdM7WVwC15s";
        
        // Init library
        pubg_objc *api = [[pubg_objc alloc] initWithAPIKey:key andRegion:kPUBGRegionNA];
        
        // Get the most current version
        [api getVersionWithCompletion:^(NSDictionary *versionInfo) {
            print_seperator();
            printf("Current version === %s\n",[versionInfo[@"version"] cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("Released === %s\n", [versionInfo[@"releasedAt"] cStringUsingEncoding:NSUTF8StringEncoding]);
            print_seperator();
        }];
        
        // Try getting a player by their nickname
        [api getPlayerByName:@"xxxPabloEscoxxx" withCompletion:^(Player *response) {
            if (response.foundPlayer) {
                print_seperator();
                printf("Player name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
                printf("Player ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
                printf("Updated timestamp === %s\n", [response.playerUpdateTimestamp cStringUsingEncoding:NSUTF8StringEncoding]);
                printf("#1 Match ID === %s\n", [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
                print_seperator();
            } else {
                printf("Player not found!");
            }
        }];
        
        // Try getting a player by their ID
        [api getPlayerByID:@"account.468977b890124455811b30dc7a138fcd" withCompletion:^(Player *response) {
            if (response.foundPlayer) {
                print_seperator();
                printf("Player name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
                printf("Player ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
                printf("Updated timestamp === %s\n", [response.playerUpdateTimestamp cStringUsingEncoding:NSUTF8StringEncoding]);
                printf("#1 Match ID === %s\n", [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
                print_seperator();
            } else {
                printf("Player not found!");
            }
        }];
        
        // Retrieve a match by its ID
        [api getMatchByID:@"c78af09f-91b1-417a-b433-0520e5768e7b" withCompletion:^(Match *response) {
            PlayerStats *stats = [response getStatsForPlayer:@"xxxPabloEscoxxx"];
            print_seperator();
            printf("Stats for %s in match\n", [stats.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("Win place === %i\n", (int)stats.winPlace);
            printf("Kill place === %i\n", (int)stats.killPlace);
            printf("Kills === %i\n", (int)stats.kills);
            printf("Assists === %i\n", (int)stats.assists);
            printf("DBNOs === %i\n", (int)stats.DBNOs);
            printf("Damage dealt === %f\n", stats.damageDealt);
            printf("Heals used === %i\n", (int)stats.heals);
            printf("Boosts used === %i\n", (int)stats.boostsUsed);
            printf("Time survived === %i\n", (int)stats.timeSurvived);
            printf("Death type === %s\n", [stats.deathType cStringUsingEncoding:NSUTF8StringEncoding]);
            print_seperator();
        }];
        pause();
    }
    return 0;
}
