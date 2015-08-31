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
NSString *const ParseClassNameMessage = @"Massage";
NSString *const SortDiscriptorByCreated = @"createdAt";

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

- (void)fetchMessageListForUser:(PTParseUser *)user success:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock {
    PTParseUser *curUser = [PTParseUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(creatorId = %@ && receiverId = %@) || (creatorId = %@ && receiverId = %@)", curUser.objectId, user.objectId, user.objectId, curUser.objectId];
    
    PFQuery *query = [PFQuery queryWithClassName:ParseClassNameMessage predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *messageList, NSError *error) {
        if(!error) {
            success([[[self sortArrayByDate:messageList] reverseObjectEnumerator] allObjects]);
        } else {
            errorBlock(error);
        }
    }];
}

- (NSMutableArray *)sortArrayByDate:(NSArray *)array {
    NSMutableArray *retArray = [NSMutableArray new];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:SortDiscriptorByCreated ascending: YES];
    [retArray addObjectsFromArray:[array sortedArrayUsingDescriptors:@[descriptor]]];
    return retArray;
}


@end
