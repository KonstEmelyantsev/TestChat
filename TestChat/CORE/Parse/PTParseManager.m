//
//  PTParseManager.m
//  PTest
//
//  Created by KonstEmelyantsev on 8/26/15.
//  Copyright (c) 2015 head-system. All rights reserved.
//

#import "PTParseManager.h"
#import "PTParseUser.h"

NSString *const ParseApplicationId = @"4vOae52Y8WKIqstWtDFWwB2i9SE22pUp1KSRKb0o";
NSString *const ParseClientKey = @"cPsqnNXtN5GtIJrqNCEmbfR2GyS1VqQIZrnarklJ";

@implementation PTParseManager

+ (instancetype)sharedManager {
    static PTParseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void)setupParse {
    [PTParseUser registerSubclass];
    [Parse setApplicationId:ParseApplicationId
                  clientKey:ParseClientKey];
}


@end
