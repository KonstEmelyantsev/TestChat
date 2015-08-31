//
//  TCChatViewController.h
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCBaseViewController.h"

@class PTParseUser;

@interface TCChatViewController : TCBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *massagesList;
@property (nonatomic, strong) PTParseUser *curUser;

- (void)updateChatForUser:(PTParseUser *)user;
- (void)stopUpdating;

@end
