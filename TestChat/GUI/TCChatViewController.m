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

@end

@implementation TCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cellWidth = self.view.frame.size.width;
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

@end
