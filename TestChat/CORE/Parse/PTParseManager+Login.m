//
//  PTParseManager+Login.m
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager+Login.h"
#import "PTParseUser.h"
#import "NSString+Validator.h"

NSString *const ParseShortPassword = @"Password length is less than 5 characters";
NSString *const ParseShortUsername = @"Username length is less than 5 characters";
NSString *const ParseInvalidEmail = @"Email is invalid";

NSString *const ParseError = @"ParseError";

@implementation PTParseManager(Login)

- (void)signUpUsername:(NSString *)username password:(NSString *)password email:(NSString *)email withSuccess:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock {
    
    if(username.length >= 5) {
        if(password.length >= 5) {
            if(email.isEmailValid) {
                PTParseUser *parseUser = [[PTParseUser alloc] initWithUsername:username password:password email:email];
                
                [parseUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        success();
                    } else {
                        errorBlock(error);
                    }
                }];
            } else {
                errorBlock([self parseErrorWithValue:ParseInvalidEmail]);
                return;
            }
        } else {
            errorBlock([self parseErrorWithValue:ParseShortPassword]);
            return;
        }
    } else {
        errorBlock([self parseErrorWithValue:ParseShortUsername]);
        return;
    }
}

- (void)logInUsername:(NSString *)username password:(NSString *)password withSuccess:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock {

    if(username.length >= 5) {
        if(password.length >= 5) {
            [PTParseUser logInWithUsernameInBackground:username password:password
                                                 block:^(PFUser *user, NSError *error) {
                                                     if(user) {
                                                         success();
                                                     } else {
                                                         errorBlock(error);
                                                     }
                                                 }];
        } else {
            errorBlock([self parseErrorWithValue:ParseShortPassword]);
            return;
        }
    } else {
        errorBlock([self parseErrorWithValue:ParseInvalidEmail]);
        return;
    }
}

- (NSError *)parseErrorWithValue:(NSString *)value {
    NSMutableDictionary *details = [NSMutableDictionary new];
    
    [details setValue:value forKey:NSLocalizedDescriptionKey];
    NSError *parseError = [NSError errorWithDomain:ParseError code:ParseLoginErrorUserData userInfo:details];

    return parseError;
}

@end
