//
//  PTParseManager+Login.m
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager+Login.h"
#import "PTParseUser.h"

NSString *const PTEmptyPassword = @"empty password";
NSString *const PTEmptyUsername = @"empty email";


@implementation PTParseManager(Login)

- (void)signUpUsername:(NSString *)username password:(NSString *)password email:(NSString *)email withSuccess:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock {
    
    if(username.length > 5) {
        if(username.length > 5) {
            
        } else {
            
        }
    } else {
        
    }
    
    PTParseUser *parseUser = [[PTParseUser alloc] initWithUsername:username password:password email:email];
    
    [parseUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            success();
        } else {
            errorBlock(error);
        }
    }];
}

- (void)logInUsername:(NSString *)username password:(NSString *)password withSuccess:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock {

    /*NSError *parseError;
    NSMutableDictionary *details = [NSMutableDictionary new];

    if(username.length > 0) {
        if(password.length > 0) {
            [PTParseUser logInWithUsernameInBackground:username password:password
                                                 block:^(PFUser *user, NSError *error) {
                                                     if(user) {
                                                         success();
                                                     } else {
                                                         errorBlock(error);
                                                     }
                                                 }];
        } else {
            [details setValue:PTEmptyPassword forKey:NSLocalizedDescriptionKey];
            parseError = [NSError errorWithDomain:@"parseError" code:500 userInfo:details];
            errorBlock(parseError);
            return;
        }
    } else {
        [details setValue:PTEmptyUsername forKey:NSLocalizedDescriptionKey];
        parseError = [NSError errorWithDomain:@"parseError" code:500 userInfo:details];
        errorBlock(parseError);
        return;
    }*/
}

@end
