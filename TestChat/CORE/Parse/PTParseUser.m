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

/*- (id)initWithUserModel:(PTUserModel *)userModel {
    self = [PTParseUser new];
    if(self) {
        [self resetFields];
        
        self.username       = userModel.username;
        self.password       = userModel.password;
        self.email          = (userModel.email.length > 0 &&
                                ![userModel.email isEqual:[NSNull null]] &&
                                ![userModel.email isEqualToString:@"(null)"]) ? userModel.email : @"";
        
        self[@"phone"]      = (userModel.phone.length > 0) ? userModel.phone : @"";
        self[@"firstname"]  = (userModel.firstname.length > 0) ? userModel.firstname : @"";
        self[@"lastname"]   = (userModel.lastname.length > 0) ? userModel.lastname : @"";
        self[@"lastname"]   = (userModel.lastname.length > 0) ? userModel.lastname : @"";
        
        self[@"fbprofile"]  = (userModel.profile_fb.length > 0) ? userModel.profile_fb : @"";
        self[@"vkprofile"]  = (userModel.profile_vk.length > 0) ? userModel.profile_vk : @"";
        self[@"gpprofile"]  = (userModel.profile_gp.length > 0) ? userModel.profile_gp : @"";

    }
    return self;
}*/

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
