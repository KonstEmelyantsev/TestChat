//
//  PTParseUser.h
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import <Parse/Parse.h>

@interface PTParseUser : PFUser

- (id)initWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email;

@end
