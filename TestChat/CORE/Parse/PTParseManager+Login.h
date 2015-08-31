//
//  PTParseManager+Login.h
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager.h"

typedef NS_ENUM(NSUInteger, ParseLoginError) {
    ParseLoginErrorInvalidCredentials = 101,
    ParseLoginErrorUserAlreadyExist = 202,
    ParseLoginErrorUserData = 500,
};

FOUNDATION_EXPORT NSString *const PTEmptyPassword;
FOUNDATION_EXPORT NSString *const PTEmptyUsername;

@interface PTParseManager(Login)

- (void)signUpUsername:(NSString *)username password:(NSString *)password email:(NSString *)email withSuccess:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock;

- (void)logInUsername:(NSString *)username password:(NSString *)password withSuccess:(PTVoidSuccess)success errorBlock:(PTFailureResponse)errorBlock;

@end
