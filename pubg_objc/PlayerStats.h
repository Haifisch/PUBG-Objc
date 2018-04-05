//
//  PlayerStats.h
//  pubg_objc
//
//  Created by Pablo Esco on 4/4/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerStats : NSObject

@property (nonatomic, assign) NSInteger DBNOs;
@property (nonatomic, assign) NSInteger assists;
@property (nonatomic, assign) NSInteger boostsUsed;
@property (nonatomic, assign) NSInteger heals;
@property (nonatomic, assign) NSInteger killPlace;
@property (nonatomic, assign) NSInteger killPoints;
@property (nonatomic, assign) NSInteger kills;
@property (nonatomic, assign) NSInteger timeSurvived;
@property (nonatomic, assign) NSInteger winPlace;
@property (nonatomic, assign) NSInteger winPoints;
@property (nonatomic, assign) double damageDealt;
@property (nonatomic, assign) double walkDistance;
@property (nonatomic, assign) NSString *deathType;
@property (nonatomic, assign) NSString *playerName;



@end
