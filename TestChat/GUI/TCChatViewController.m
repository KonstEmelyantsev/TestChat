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

static NSString *messageCellOutId   = @"messageCellOut";
static NSString *messageCellInId    = @"messageCellIn";

@interface TCChatViewController ()

{
    CGFloat _cellWidth;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;

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
    PFObject *message = [self.massagesList objectAtIndex:indexPath.row];
    
    NSString *cellId, *username;
    NSString *creatorId = message[@"creatorId"];
    if([creatorId isEqualToString:[PTParseUser currentUser].objectId]) {
        cellId = messageCellInId;
        username = [PTParseUser currentUser].username;
    } else if ([creatorId isEqualToString:self.curUser.objectId]) {
        cellId = messageCellOutId;
        username = self.curUser.username;
    }
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [UITableViewCell new];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    [label setText:username];

    UITextView *messageTV = (UITextView *)[cell viewWithTag:2];
    [messageTV setText:message[@"text"]];
    
    [messageTV.layer setCornerRadius:5.f];
    [messageTV setClipsToBounds:YES];
    
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
    self.curUser = user;
    
    [[PTParseManager sharedManager] fetchMessageListForUser:user success:^(NSArray *array) {
        if(array.count != self.massagesList.count) {
            [self reloadDataByArray:array];
        }
    } errorBlock:^(NSError *error) {

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

- (IBAction)sendMessageClick:(id)sender {
    if(self.messageTF.text.length > 0) {
        [self showBlockView];
        NSString *message = self.messageTF.text;
        self.messageTF.text = @"";
        [[PTParseManager sharedManager] sendMassage:message toUser:self.curUser success:^{
            [self hideBlockView];
        } errorBlock:^(NSError *error) {
            [self hideBlockView];
            
        }];
    } else {
        
    }
}

- (void)reloadDataByArray:(NSArray *)array {
    self.massagesList = (NSMutableArray *)array;
    [self.tableView reloadData];
    if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
        [self scrollTableViewToBottom];
    }
}

- (void)scrollTableViewToBottom {
    CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
    [self.tableView setContentOffset:offset animated:NO];
}

@end
