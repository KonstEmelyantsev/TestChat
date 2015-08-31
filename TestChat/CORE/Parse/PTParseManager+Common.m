//
//  PTParseManager+Common.m
//  PTest
//
//  Created by KonstEmelyantsev on 8/28/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager+Common.h"
#import "PTParseUser.h"

NSString *const ParseClassNameUser = @"_User";

@implementation PTParseManager(Common)

- (void)fetchUsersListSuccess:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock {
    PFQuery *query = [PFQuery queryWithClassName:ParseClassNameUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *avatarList, NSError *error) {
        if(!error) {
            success(avatarList);
        } else {
            errorBlock(error);
        }
    }];
}

@end
