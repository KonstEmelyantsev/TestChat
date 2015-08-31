//
//  TCLoginViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCLoginViewController.h"
#import "PTParseHeader.h"
#import "TCMainViewController.h"

@interface TCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation TCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginClick:(id)sender {
    NSString *username = self.usernameTF.text;
    NSString *password = self.passwordTF.text;
    [[PTParseManager sharedManager] logInUsername:username password:password withSuccess:^{
        TCMainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TCMainViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
