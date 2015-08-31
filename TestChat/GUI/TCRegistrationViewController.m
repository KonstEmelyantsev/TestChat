//
//  TCRegistrationViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCRegistrationViewController.h"
#import "PTParseHeader.h"
#import "TCMainViewController.h"

@interface TCRegistrationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;

@end

@implementation TCRegistrationViewController

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registrationClick:(id)sender {
    NSString *username = self.usernameTF.text;
    NSString *password = self.passwordTF.text;
    NSString *email = self.emailTF.text;
    
    //Where is ofline field validation?
    
    [self showBlockView];
    [[PTParseManager sharedManager] signUpUsername:username password:password email:email withSuccess:^{
        [self hideBlockView];
        TCMainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TCMainViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    } errorBlock:^(NSError *error) {
        [self hideBlockView];
    }];
}

@end
