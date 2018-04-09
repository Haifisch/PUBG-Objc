//
//  Telemetry.m
//  Telemetry
//
//  Created by Pablo Esco on 4/7/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import "Telemetry.h"

@implementation Telemetry_Player_Killed

@end

@implementation Telemetry

- (NSArray *)allEventsForType:(NSString *)eventType {
    NSMutableArray *collected = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.telemetryData.count; i++) {
        NSString *currentEvent = self.telemetryData[i][@"_T"];
        if ([currentEvent isEqualToString:eventType]) {
            [collected addObject:self.telemetryData[i]];
        }
    }
    return collected;
}

- (NSArray *)allEventTypes {
    return @[@"LogPlayerLogin", @"LogPlayerCreate", @"LogPlayerPosition", @"LogPlayerAttack", @"LogItemPickup", @"LogItemEquip", @"LogItemUnequip", @"LogVehicleRide", @"LogMatchDefinition", @"LogMatchStart", @"LogGameStatePeriodic", @"LogVehicleLeave", @"LogPlayerTakeDamage", @"LogPlayerLogout", @"LogItemAttach", @"LogItemDrop", @"LogPlayerKill", @"LogItemDetach", @"LogItemUse", @"LogCarePackageSpawn", @"LogVehicleDestroy", @"LogCarePackageLand", @"LogMatchEnd"];
}

- (void)parseTelemetryWithCompletion:(telemetryCompletion)completion {
    NSMutableDictionary *events = [[NSMutableDictionary alloc] init];
    // Initial parsing, split out events as needed.
    NSArray *types = [self allEventTypes];
    for (int i = 0; i < types.count; i++) {
        [events setObject:[self allEventsForType:types[i]] forKey:types[i]];
    }
    completion(events);
}

// Statistics helpers
- (int)numberOfUses:(NSString *)itemId {
    NSArray *dataArray = [self allEventsForType:@"LogItemUse"];
    int count = 0;
    for (int i = 0; i < dataArray.count; i++) {
        NSString *item = dataArray[i][@"item"][@"itemId"];
        if ([item isEqualToString:itemId]) {
            count++;
        }
    }
    return count;
}

// Time specific events
- (NSDate *)epoch {
    NSArray *dataArray = [self allEventsForType:@"LogMatchDefinition"];
    //yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ"];
    NSDate *date = [dateFormat dateFromString:dataArray[0][@"_D"]];
    return date;
}

- (NSDate *)matchStart {
    NSArray *dataArray = [self allEventsForType:@"LogMatchStart"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SS'Z'"];
    NSDate *date = [dateFormat dateFromString:dataArray[0][@"_D"]];
    return date;
}

- (NSDate *)matchEnd {
    NSArray *dataArray = [self allEventsForType:@"LogMatchEnd"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SS'Z'"];
    NSDate *date = [dateFormat dateFromString:dataArray[0][@"_D"]];
    return date;
}

@end
