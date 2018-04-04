//
//  pubg_objc.m
//  pubg_objc
//
//  Created by Pablo Esco on 4/3/18.
//  Copyright © 2018 haifisch. All rights reserved.
//

#import "pubg_objc.h"

NSString *API_KEY;
NSString *Region;

@implementation pubg_objc
// Initializers
-(id)init {
    if (self = [super init]) {
        API_KEY = nil;
        
    }
    return self;
}

- (id)initWithAPIKey:(NSString *)key andRegion:(NSString *)region {
    self = [self init];
    if (self) {
        API_KEY = key;
        Region = region;
    }
    return self;
}

// HTTP Requests
- (void)makeRequestWithEndpoint:(NSString *)endpoint withCompletion:(httpResponse)completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.playbattlegrounds.com/shards/%@/%@", Region, endpoint]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/vnd.api+json" forHTTPHeaderField:@"Accept"];
    [request setValue:API_KEY forHTTPHeaderField:@"Authorization"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if (!error) {
                        NSDictionary *parsed = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                        if (!parsed[@"errors"]) {
                            completion(parsed);
                        } else {
                            completion(NULL);
                        }
                    }
                }] resume];
}

// Player Queries
- (void)getPlayerByName:(NSString *)playerName withCompletion:(playerResponse)completion {
    [self makeRequestWithEndpoint:[NSString stringWithFormat:@"players?filter[playerNames]=%@", playerName] withCompletion:^(id response) {
        if (response == NULL) {
            completion(NULL);
            return;
        }
        Player *obj = [[Player alloc] init];
        obj.foundPlayer = TRUE;
        obj.playerIdentifier = response[@"data"][0][@"id"];
        obj.playerName = response[@"data"][0][@"attributes"][@"name"];
        obj.playerUpdateTimestamp = response[@"data"][0][@"attributes"][@"updatedAt"];
        obj.playerMatches = response[@"data"][0][@"relationships"][@"matches"][@"data"];
        completion(obj);
    }];
}

- (void)getPlayerByID:(NSString *)identifier withCompletion:(playerResponse)completion {
    [self makeRequestWithEndpoint:[NSString stringWithFormat:@"players?filter[playerIds]=%@", identifier] withCompletion:^(id response) {
        if (response == NULL) {
            completion(NULL);
            return;
        }
        Player *obj = [[Player alloc] init];
        obj.foundPlayer = TRUE;
        obj.playerIdentifier = response[@"data"][0][@"id"];
        obj.playerName = response[@"data"][0][@"attributes"][@"name"];
        obj.playerUpdateTimestamp = response[@"data"][0][@"attributes"][@"updatedAt"];
        obj.playerMatches = response[@"data"][0][@"relationships"][@"matches"][@"data"];
        completion(obj);
    }];
}

// PUBG Version Info
- (void)getVersionWithCompletion:(versionDictionary)completion {
    NSURL *url = [NSURL URLWithString:@"https://api.playbattlegrounds.com/status"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/vnd.api+json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if (!error) {
                        NSDictionary *parsed = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                        if (!parsed[@"errors"]) {
                            completion(parsed[@"data"][@"attributes"]);
                        } else {
                            completion(NULL);
                        }
                    }
                }] resume];
}
@end
