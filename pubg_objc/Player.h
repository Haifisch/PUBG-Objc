//
//  Player.h
//  pubg_objc
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property (nonatomic, assign) BOOL foundPlayer;
@property (nonatomic, assign) NSString *playerIdentifier;
@property (nonatomic, assign) NSString *playerName;
@property (nonatomic, assign) NSString *playerUpdateTimestamp;
@property (nonatomic, assign) NSArray *playerMatches;


@end
