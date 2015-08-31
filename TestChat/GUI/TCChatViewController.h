//
//  TCChatViewController.h
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *massagesList;

@end
