//
//  TCBaseViewController.m
//  TestChat
//
//  Created by KonstEmelyantsev on 8/31/15.
//  Copyright (c) 2015 KonstEmelyantsev. All rights reserved.
//

#import "TCBaseViewController.h"

#define MAX_LENGTH 30

@interface TCBaseViewController ()

@property (weak, nonatomic) UIView *blockView;

@end

@implementation TCBaseViewController

#pragma mark blocking ui function

- (void)showBlockView {
    if(!self.blockView) {
        UIViewController *curVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        UIView *blockView = [[UIView alloc]initWithFrame:curVC.view.bounds];
        blockView.backgroundColor = [UIColor clearColor];
        UIActivityIndicatorView *aInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aInd.hidden = NO;
        aInd.center = blockView.center;
        
        [aInd setColor:[UIColor grayColor]];
        
        [blockView addSubview:aInd];
        [aInd startAnimating];
        
        self.blockView = blockView;
        self.blockView.alpha = 0;
        self.blockView.hidden = NO;
        
        [curVC.view addSubview:self.blockView];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.blockView.alpha = 1;
        }];
    }
    
}

- (void)hideBlockView {
    self.blockView.alpha = 0.1;
    [UIView animateWithDuration:0.3 animations:^{
        self.blockView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished) {
            [self.blockView removeFromSuperview];
            self.blockView = nil;
        }
    }];
}

#pragma mark textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if([textField.text isEqualToString:@""] && [string isEqualToString:@" "]) {
        textField.text = @"";
        return NO;
    }
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= MAX_LENGTH || returnKey;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
