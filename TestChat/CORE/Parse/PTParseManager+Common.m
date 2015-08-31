//
//  PTParseManager+Common.m
//  PTest
//
//  Created by KonstEmelyantsev on 8/28/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager+Common.h"
#import "PTParseUser.h"

NSString *const PTClassNameInvite = @"Notification";
NSString *const PTClassNameGame = @"Game";

@implementation PTParseManager(Common)

- (void)fetchAvatarListSuccess:(void (^)(NSArray *))success errorBlock:(void (^)(NSError *))errorBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"Avatar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *avatarList, NSError *error) {
        if(!error) {
            success(avatarList);
        } else {
            errorBlock(error);
        }
    }];
}

- (void)fetchInvitesListSuccess:(void (^)(NSArray *))success errorBlock:(void (^)(NSError *))errorBlock {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"receiverId = %@", [PTParseUser currentUser].objectId];
    PFQuery *query = [PFQuery queryWithClassName:PTClassNameInvite predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *inviteList, NSError *error) {
        if(!error) {
            success(inviteList);
        } else {
            errorBlock(error);
        }
    }];

}

- (void)fetchGamesListSuccess:(void (^)(NSArray *))success errorBlock:(void (^)(NSError *))errorBlock {
    NSMutableArray *retObjects = [NSMutableArray new];
    NSMutableArray *games = [[NSMutableArray alloc] initWithArray:[[PTParseUser currentUser] objectForKey:@"games"]];
    
    if(games.count > 0) {
        for (NSString *game in games) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId = %@", game];
            PFQuery *query = [PFQuery queryWithClassName:PTClassNameGame predicate:predicate];
            [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if(!error){
                    [retObjects addObject:object];
                    success(retObjects);
                } else {
                    errorBlock(error);
                }
            }];
        }
    } else {
        success(retObjects);
    }
}

@end
