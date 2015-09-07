//
//  TCMessagesViewController.h
//  TestChat
//
//  Created by KonstEmelyantsev on 9/7/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessages.h>

@class PTParseUser;

@interface TCMessagesViewController : JSQMessagesViewController

@property (nonatomic, strong) NSMutableArray *messagesList;
@property (nonatomic, strong) PTParseUser *curUser;

- (void)loadMessagesFor:(PTParseUser *)user;

@end
