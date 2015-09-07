//
//  TCUsersViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCUsersViewController.h"
#import "PTParseHeader.h"
#import "TCMainViewController.h"
#import "TCChatViewController.h"
#import "TCMessagesViewController.h"

@interface TCUsersViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

CGFloat const PTUserCellHeight = 45.f;

#define UserCellId @"userCell"

@implementation TCUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.usersList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellContactId = UserCellId;
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellContactId];
    
    if (cell == nil) {
        cell = [UITableViewCell new];
    }
    
    PTParseUser *parseUser = [self.usersList objectAtIndex:indexPath.row];
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    [label setText:parseUser.username];
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PTUserCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTParseUser *user = [self.usersList objectAtIndex:indexPath.row];
    //[(TCMainViewController *)self.parentViewController updateChatForUser:user];
    
    TCMessagesViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TCMessagesViewController"];
    [vc loadMessagesFor:user];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)refreshData {
    [[PTParseManager sharedManager] fetchUsersListSuccess:^(NSArray *array) {
        self.usersList = [self usersListWithoutYourselfFrom:(NSMutableArray *)array];
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)usersListWithoutYourselfFrom:(NSMutableArray *)users {
    PTParseUser *userToRemove;
    for(PTParseUser *user in users) {
        if([user.objectId isEqualToString:[PTParseUser currentUser].objectId]) {
            userToRemove = user;
        }
    }
    [users removeObject:userToRemove];
    return users;
}

@end
