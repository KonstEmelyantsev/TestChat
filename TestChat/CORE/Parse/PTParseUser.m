//
//  PTParseUser.m
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseUser.h"
#import "PTParseManager.h"

@implementation PTParseUser

- (id)initWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email {
    self = [super init];
    if(self) {
        [self resetFields];
        
        self.username       = username;
        self.password       = password;
        self.email          = email;
        
    }
    return self;
}

- (void)resetFields {
    self.username                   = @"";
    self.password                   = @"";
    self.email                      = @"";
    //self[@"phone"]                  = @"";
    self[@"firstname"]              = @"";
    self[@"lastname"]               = @"";
    //self[@"fbprofile"]              = @"";
    //self[@"vkprofile"]              = @"";
    //self[@"gpprofile"]              = @"";
    //self[@"avatar"]                 = [NSNull null];
}

@end
