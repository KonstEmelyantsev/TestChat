//
//  TCMainViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCMainViewController.h"
#import "TCUsersViewController.h"
#import "TCChatViewController.h"
#import "PTParseHeader.h"

@implementation TCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childs = self.childViewControllers;
    for(UIViewController *vc in childs) {
        if([vc isKindOfClass:[TCUsersViewController class]]) {
            self.usersVC = (TCUsersViewController *)vc;
        } else if([vc isKindOfClass:[TCChatViewController class]]) {
            self.chatVC = (TCChatViewController *)vc;
        }
    }
    
}

- (void)updateChatForUser:(PTParseUser *)user {
    [self.chatVC updateChatForUser:user];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
