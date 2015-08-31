//
//  NSString+Validator.m
//  PTest
//
//  Created by Константин on 05.12.14.
//  Copyright (c) 2014 head-system. All rights reserved.
//

#import "NSString+Validator.h"

@implementation NSString (Validator)

- (BOOL)isEmailValid {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailPredicate evaluateWithObject:self];
}

@end
