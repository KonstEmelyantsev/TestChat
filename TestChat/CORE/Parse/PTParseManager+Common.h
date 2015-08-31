//
//  PTParseManager+Common.h
//  PTest
//
//  Created by KonstEmelyantsev on 8/28/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager.h"

@interface PTParseManager(Common)

- (void)fetchAvatarListSuccess:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock;
- (void)fetchInvitesListSuccess:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock;
- (void)fetchGamesListSuccess:(PTSuccessResponse)success errorBlock:(PTFailureResponse)errorBlock;

@end
