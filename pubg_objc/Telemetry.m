//
//  Telemetry.m
//  pubg_objc
//
//  Created by Pablo Esco on 4/5/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import "Telemetry.h"

@implementation Telemetry



// Telemetry info
- (NSString *)getTelemetryDownloadURLForMatch:(Match*)match {
    for (int i = 0; i < match.playersInMatch.count; i++) {
        if ([match.playersInMatch[i][@"type"] isEqualToString:@"asset"] && [match.playersInMatch[i][@"attributes"][@"name"] isEqualToString:@"telemetry"]) {
            return match.playersInMatch[i][@"attributes"][@"URL"];
        }
    }
    return NULL;
}

@end
