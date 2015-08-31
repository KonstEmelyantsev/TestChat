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
{
    CGFloat keyboardHeight;
}
@property (weak, nonatomic) UIView *blockView;
@property (weak, nonatomic) UITextField *activeField;

@end

@implementation TCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    [self makeScroll:notification];
}

- (void)makeScroll:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    keyboardHeight = keyboardRect.size.height;
    CGPoint point = [self.activeField.superview convertPoint:self.activeField.frame.origin toView:nil];
    CGFloat tvY = point.y + self.activeField.frame.size.height;
    CGFloat kbY = [[UIScreen mainScreen] bounds].size.height - keyboardHeight;
    if(tvY < kbY) {
        
    } else {
        CGPoint scrollPoint = CGPointMake(0, (tvY - kbY + 10 /*self.activeField.frame.size.height*/));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)sender {
    self.activeField = sender;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

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
