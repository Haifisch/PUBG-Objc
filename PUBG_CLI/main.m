//
//  main.m
//  PUBG
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pubg_objc.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Enter your PUBG API key here (see https://developer.playbattlegrounds.com for more details)
        NSString *key = @"";
        // Init library
        pubg_objc *api = [[pubg_objc alloc] initWithAPIKey:key andRegion:kPUBGRegionNA];
        // Try getting a player by their nickname
        [api getPlayerByName:@"xxxPabloEscoxxx" withCompletion:^(Player *response) {
            if (response.foundPlayer) {
                NSLog(@"Player name === %@", response.playerName);
                NSLog(@"Player ident === %@", response.playerIdentifier);
                NSLog(@"Updated timestamp === %@", response.playerUpdateTimestamp);
                NSLog(@"Available matches === %@", response.playerMatches);
            } else {
                NSLog(@"Player not found!");
            }
        }];
        // Try getting a player by their ID
        [api getPlayerByID:@"account.468977b890124455811b30dc7a138fcd" withCompletion:^(Player *response) {
            if (response.foundPlayer) {
                NSLog(@"Player name === %@", response.playerName);
                NSLog(@"Player ident === %@", response.playerIdentifier);
                NSLog(@"Updated timestamp === %@", response.playerUpdateTimestamp);
                NSLog(@"Available matches === %@", response.playerMatches);
            } else {
                NSLog(@"Player not found!");
            }
        }];
        pause();
    }
    return 0;
}
