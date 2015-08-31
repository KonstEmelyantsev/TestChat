//
//  PTParseManager.h
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

typedef void(^PTVoidSuccess)();
typedef void(^PTSuccessResponse)(NSArray *array);
typedef void(^PTFailureResponse)(NSError *error);

@interface PTParseManager : NSObject

+ (instancetype)sharedManager;

- (void)setupParse;

@end
