//
//  Telemetry.h
//  pubg_objc
//
//  Created by Pablo Esco on 4/5/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"
@interface Telemetry : NSObject

// Telemetry info
- (NSString *)getTelemetryDownloadURLForMatch:(Match*)match;

@end
