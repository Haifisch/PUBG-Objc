//
//  main.m
//  PUBG
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUBG.h"

// Global reusable objects
PUBG *libPUBG;
NSString *KEY = nil;

// Reusables for logging
void print_seperator() {
    printf("[-----------------------------------------------------------------]\n");
}

// Test methods
NSString *testMatchIdentifier = nil;
void player_query_tests() {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    // Try getting a player by their nickname
    [libPUBG getPlayerByName:@"xxxPabloEscoxxx" withCompletion:^(Player *response) {
        if (response.foundPlayer) {
            print_seperator();
            printf("\tPlayer found by their nickname!\n");
            printf("\tPlayer name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tPlayer ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tUpdated timestamp === %s\n", [response.playerUpdateTimestamp cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tAvailable matches === %i\n", (int)[response.playerMatches count]);
            printf("\tAll available matches;\n");
            for (int i = 0; i < response.playerMatches.count; i++) {
                printf("\t\t#%i -- %s\n", i+1, [response.playerMatches[i][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
            }
            dispatch_semaphore_signal(sema);
        } else {
            printf("\tPlayer not found!\n");
            dispatch_semaphore_signal(sema);
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_t sema2 = dispatch_semaphore_create(0);
    // Try getting a player by their ID
    [libPUBG getPlayerByID:@"account.468977b890124455811b30dc7a138fcd" withCompletion:^(Player *response) {
        if (response.foundPlayer) {
            print_seperator();
            printf("\tPlayer found by their ID!\n");
            printf("\tPlayer name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tPlayer ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tUpdated timestamp === %s\n", [response.playerUpdateTimestamp cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tAvailable matches === %i\n", (int)[response.playerMatches count]);
            printf("\tAll available matches;\n");
            for (int i = 0; i < response.playerMatches.count; i++) {
                printf("\t\t#%i -- %s\n", i+1, [response.playerMatches[i][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
            }
            testMatchIdentifier = response.playerMatches[arc4random() % response.playerMatches.count][@"id"];
            dispatch_semaphore_signal(sema2);
        } else {
            printf("\tPlayer not found!\n");
            dispatch_semaphore_signal(sema2);
        }
    }];
    dispatch_semaphore_wait(sema2, DISPATCH_TIME_FOREVER);
}

void match_query_tests() {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    // Retrieve a match by its ID
    __block Match *foundMatch;
    [libPUBG getMatchByID:@"a29a29b5-8835-4537-aca7-c86deb81adae" withCompletion:^(Match *response) {
        if (response.foundMatch) {
            foundMatch = response;
            print_seperator();
            printf("\tMatch found!\n");
            printf("\tMatch ID === %s\n", [response.matchID cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tMatch mode === %s\n", [response.gameMode cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tMatch duration === %i (~%d minutes)\n", (int)response.duration, ((int)response.duration/60));
            Telemetry *telemetry = [[Telemetry alloc] init];
            printf("\tTelemetry download === %s\n\n", [[telemetry getTelemetryDownloadURLForMatch:response] cStringUsingEncoding:NSUTF8StringEncoding]);
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
            dispatch_semaphore_signal(sema);
        } else {
            printf("\tMatch not found!\n");
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

void run_main_tests() {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    // Get the most current version
    [libPUBG getVersionWithCompletion:^(NSDictionary *versionInfo) {
        print_seperator();
        printf("\tCurrent version === %s\n",[versionInfo[@"version"] cStringUsingEncoding:NSUTF8StringEncoding]);
        printf("\tReleased === %s\n", [versionInfo[@"releasedAt"] cStringUsingEncoding:NSUTF8StringEncoding]);
        dispatch_semaphore_signal(sema);

    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    player_query_tests();
    match_query_tests();
}

void get_player_by_name(BOOL shouldPrintExtra, NSString *playerName) {
    if (playerName == nil) {
        return;
    }
    printf("Running query now...\n");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [libPUBG getPlayerByName:playerName withCompletion:^(Player *response) {
        if (response.foundPlayer) {
            printf("Player found!\n");
            print_seperator();
            printf("\tPlayer name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tPlayer ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
            NSDate *date = [dateFormat dateFromString:response.playerUpdateTimestamp];
            [dateFormat setDateFormat:@"EEEE, d MMMM yyyy hh:mm:ss a"];
            printf("\tDate updated === %s\n", [[dateFormat stringFromDate:date] cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tAvailable matches === %i\n", (int)[response.playerMatches count]);
            if (shouldPrintExtra) {
                printf("\tAll available matches;\n");
                for (int i = 0; i < response.playerMatches.count; i++) {
                    printf("\t\t#%i -- %s\n", i+1, [response.playerMatches[i][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
                }
            } else {
                printf("\t#1 Match ID === %s\n", [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
            }
            print_seperator();
            dispatch_semaphore_signal(sema);
        } else {
            printf("\t%s was not found, or the API is denying access.\n", [playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            dispatch_semaphore_signal(sema);
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

}

void get_player_by_identifier(BOOL shouldPrintExtra, NSString *playerIdentifier) {
    if (playerIdentifier == nil) {
        return;
    }
    printf("Running query now...\n");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [libPUBG getPlayerByID:playerIdentifier withCompletion:^(Player *response) {
        if (response.foundPlayer) {
            printf("Player found!\n");
            print_seperator();
            printf("\tPlayer name === %s\n", [response.playerName cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tPlayer ident === %s\n", [response.playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
            NSDate *date = [dateFormat dateFromString:response.playerUpdateTimestamp];
            [dateFormat setDateFormat:@"EEEE, d MMMM yyyy hh:mm:ss a"];
            printf("\tDate updated === %s\n", [[dateFormat stringFromDate:date] cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tAvailable matches === %i\n", (int)[response.playerMatches count]);
            if (shouldPrintExtra) {
                for (int i = 0; i < response.playerMatches.count; i++) {
                    printf("\t#%i -- %s\n", i+1, [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
                }
            } else {
                printf("\t#1 Match ID === %s\n", [response.playerMatches[0][@"id"] cStringUsingEncoding:NSUTF8StringEncoding]);
            }            print_seperator();
            dispatch_semaphore_signal(sema);
        } else {
            printf("\t%s was not found, or the API is denying access.\n", [playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
            dispatch_semaphore_signal(sema);
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

void get_match_by_identifier(NSString *matchID, BOOL printPlayeStats, NSString *playerName, BOOL shouldPrintTeam) {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    // Retrieve a match by its ID
    [libPUBG getMatchByID:matchID withCompletion:^(Match *response) {
        if (response.foundMatch) {
            printf("Match found!\n");
            print_seperator();
            printf("\tMatch ID === %s\n", [response.matchID cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tMatch mode === %s\n", [response.gameMode cStringUsingEncoding:NSUTF8StringEncoding]);
            printf("\tMatch duration === %i (~%d minutes)\n", (int)response.duration, ((int)response.duration/60));
            Telemetry *telemetry = [[Telemetry alloc] init];
            printf("\tTelemetry download === %s\n", [[telemetry getTelemetryDownloadURLForMatch:response] cStringUsingEncoding:NSUTF8StringEncoding]);
            print_seperator();
            if (printPlayeStats && playerName != nil) {
                // Get player stats
                PlayerStats *stats = [response getStatsForPlayer:playerName];
                printf("\n\"%s\" stats for match %s\n", [stats.playerName cStringUsingEncoding:NSUTF8StringEncoding], [matchID cStringUsingEncoding:NSUTF8StringEncoding]);
                print_seperator();
                printf("\tTime survived === %i (~%d minutes)\n", (int)stats.timeSurvived, ((int)stats.timeSurvived/60));
                printf("\tWin place === %i/100\n", (int)stats.winPlace);
                printf("\tKill place === %i/100\n", (int)stats.killPlace);
                printf("\tKills === %i\n", (int)stats.kills);
                printf("\tAssists === %i\n", (int)stats.assists);
                printf("\tDBNOs === %i\n", (int)stats.DBNOs);
                printf("\tDamage dealt === %f\n", stats.damageDealt);
                printf("\tHeals used === %i\n", (int)stats.heals);
                printf("\tBoosts used === %i\n", (int)stats.boostsUsed);
                printf("\tDeath type === %s\n", [stats.deathType cStringUsingEncoding:NSUTF8StringEncoding]);
                if (([response.gameMode isEqualToString:@"squad"] || [response.gameMode isEqualToString:@"duo"] || [response.gameMode isEqualToString:@"squad-fpp"] || [response.gameMode isEqualToString:@"duo-fpp"]) && shouldPrintTeam) {
                    NSArray *team = [response getAllPlayersInTeamWith:playerName]; // Index 0 holds the IDs, 1 holds the nicknames, 2 holds the player identifiers
                    printf("\tTeammates;\n");
                    for (int i = 0; i < [team[1] count]; i++) {
                        printf("\t\t\"%s\" (%s)\n", [team[1][i] cStringUsingEncoding:NSUTF8StringEncoding], [team[2][i] cStringUsingEncoding:NSUTF8StringEncoding]);
                    }
                }
                print_seperator();
            }
            dispatch_semaphore_signal(sema);
        } else {
            printf("\tMatch not found!\n");
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

void print_help() {
    printf("Available commands;\n");
    printf("[-help] Show this prompt\n");
    printf("[-key (API key)] -- Your API key aquired from https://developer.playbattlegrounds.com (Required as 1st arg)\n");
    printf("[-doTests] -- Run basic tests (get user, match data, etc.)\n");
    printf("[-findPlayer] -- Find a player.\n");
    printf("    Arguments;\n");
    printf("\t[-playerName \"player name\"] -- Find player by their name. (Required)\n");
    printf("\t[-playerIdentifier \"player identifier\"] -- Find player by their identifier. (Optional)\n");
    printf("\t[-extra] -- Print out all matches availble for the player. (Optional)\n");
    printf("[-findMatch] -- Find and print out general data for a match\n");
    printf("    Arguments;\n");
    printf("\t[-matchIdentifier \"match identifier\"] -- Target match identifier. (Required)\n");
    printf("\t[-playerName \"player name\"] -- Print out a player's stats in a match using their in-game nickname (Optional)\n");
    printf("\t[-extra] -- Print all teammates for player (Optional, [-s] required!)\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printf("PUBG API CLI -- v1.0.0 for macOS\nWritten by Haifisch (haifisch@hbang.ws)\n\n");
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        if (args.count <= 1) {
            print_help();
            return 0;
        }
        /*
            Keeping track of what actions the user selected
            Method index is currently 1-4
                1) run run_main_tests()
                2) run get_player_by_name() or get_player_by_identifier()
                3) run get_match_by_identifier()
         */
        int methodIndex = 0;
        NSString *matchIdentifier = nil;
        NSString *playerName = nil;
        NSString *playerIdentifier = nil;
        BOOL printExtra = false;
        for (int i = 0; i < args.count; i++) {
            if ([args[i] isEqualToString:@"-key"]) { // check for our API key first
                KEY = (NSString *)args[i+1];
            }
            if ([args[i] isEqualToString:@"-doTests"]) {
                methodIndex = 1;
            }
            if ([args[i] isEqualToString:@"-help"]) {
                print_help();
                return 0;
            }
            if ([args[i] isEqualToString:@"-findPlayer"]) {
                methodIndex = 2;
            }
            if ([args[i] isEqualToString:@"-findMatch"]) {
                methodIndex = 3;
            }
            if ([args[i] isEqualToString:@"-playerName"]) {
                playerName = (NSString *)args[i+1];
            }
            if ([args[i] isEqualToString:@"-match"]) {
                matchIdentifier = (NSString *)args[i+1];
            }
            if ([args[i] isEqualToString:@"-playerIdentifier"]) {
                playerIdentifier = (NSString*)args[i+1];
            }
            if ([args[i] isEqualToString:@"-extra"]) {
                printExtra = true;
            }
        }
        libPUBG = [[PUBG alloc] initWithAPIKey:KEY andRegion:kPUBGRegionNA];
        switch (methodIndex) {
            case 1:
                run_main_tests();
                break;
            case 2:
                if (playerName != nil) {
                    printf("Trying to find player \"%s\".\n", [playerName cStringUsingEncoding:NSUTF8StringEncoding]);
                    get_player_by_name(printExtra, playerName);
                }
                if (playerIdentifier != nil) {
                    printf("Trying to find player \"%s\".\n", [playerIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
                    get_player_by_identifier(printExtra, playerIdentifier);
                }
                break;
            case 3:
                printf("Searching for match with identifier %s\n", [matchIdentifier cStringUsingEncoding:NSUTF8StringEncoding]);
                get_match_by_identifier(matchIdentifier, (playerName != nil) ? YES : NO, playerName, printExtra);
                break;
            default:
                break;
        }
    }
    return 0;
}
