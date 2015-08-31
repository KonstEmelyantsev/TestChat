//
//  PTParseManager+Common.h
//  PTest
//
//  Created by KonstEmelyantsev on 8/28/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager.h"

@class PTParseUser;

@interface PTParseManager(Common)

- (void)fetchUsersListSuccess:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock;
- (void)fetchMessageListForUser:(PTParseUser *)user success:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock;
- (void)sendMassage:(NSString *)text toUser:(PTParseUser *)user success:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock;

@end
