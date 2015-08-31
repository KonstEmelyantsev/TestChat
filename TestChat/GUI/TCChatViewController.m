//
//  TCChatViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCChatViewController.h"
#import "PTParseHeader.h"

CGFloat const PTMessageCellHeight = 45.f;

#define MessageCellId       @"messageCell"

@interface TCChatViewController ()

{
    CGFloat _cellWidth;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSTimer *timer;

@end

@implementation TCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellWidth = self.view.frame.size.width;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(refreshData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.massagesList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellContactId = MessageCellId;
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellContactId];
    
    if (cell == nil) {
        cell = [UITableViewCell new];
    }
    
    PFObject *message = [self.massagesList objectAtIndex:indexPath.row];
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    UITextView *messageTV = (UITextView *)[cell viewWithTag:2];
    [messageTV setText:message[@"text"]];
    
    NSString *creatorId = message[@"creatorId"];
    if([creatorId isEqualToString:[PTParseUser currentUser].objectId]) {
        [label setText:[PTParseUser currentUser].username];
    } else if ([creatorId isEqualToString:self.curUser.objectId]) {
        [label setText:self.curUser.objectId];
    }
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *message = (PFObject *)[self.massagesList objectAtIndex:indexPath.row];
    NSString *text = (NSString *)message[@"text"];
    return PTMessageCellHeight + [self heightForTextViewRectWithWidth:_cellWidth andText:text];
}

- (CGFloat)heightForTextViewRectWithWidth:(CGFloat)width andText:(NSString *)text {
    UIFont * font = [UIFont systemFontOfSize:14.0f];
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    CGFloat area = size.height * size.width;
    CGFloat buffer = 3.0f;
    
    return floor(area/width) + buffer;
}

- (void)updateChatForUser:(PTParseUser *)user {
    //[self showBlockView];
    self.curUser = user;
    [[PTParseManager sharedManager] fetchMessageListForUser:user success:^(NSArray *array) {
        //[self hideBlockView];
        self.massagesList = (NSMutableArray *)array;
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        //[self hideBlockView];
    }];
}

- (void)refreshData {
    if(self.curUser) {
        [self updateChatForUser:self.curUser];
    }
}

- (void)stopUpdating {
    [self.timer invalidate];
    self.timer = nil;
}

@end
