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

- (void)signUpUser:(PTUserModel *)userModel withSuccess:(void (^)(void))success errorBlock:(void (^)(NSError *))errorBlock {
    
    /*PTParseUser *parseUser = [[PTParseUser alloc] initWithUserModel:userModel];
    
    [parseUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            success();
        } else {
            errorBlock(error);
        }
    }];*/
}

- (void)signUpSocialUser:(PTUserModel *)userModel withSuccess:(void (^)(void))success errorBlock:(void (^)(NSError *))errorBlock {
    
    /*PTParseUser *parseUser = [[PTParseUser alloc] initWithUserModel:userModel];
    
    [parseUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            success();
        } else if (error.code == PTLoginErrorUserAlreadyExist) {
            
            //if user is already exist signIn
            [self logInUsername:parseUser.username password:parseUser.password withSuccess:success errorBlock:errorBlock];
            
        } else {
            errorBlock(error);
        }
    }];*/
}

- (void)logInUsername:(NSString *)username password:(NSString *)password withSuccess:(void (^)(void))success errorBlock:(void (^)(NSError *))errorBlock {

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
