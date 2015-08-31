//
//  TCMainViewController.h
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCUsersViewController;
@class TCChatViewController;
@class PTParseUser;

@interface TCMainViewController : UIViewController

@property (nonatomic, strong) TCUsersViewController *usersVC;
@property (nonatomic, strong) TCChatViewController *chatVC;

- (void)updateChatForUser:(PTParseUser *)user;

@end
