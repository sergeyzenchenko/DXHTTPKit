//
//  DXParam.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPParamKey.h"
#import "DXHTTPFormFileDescriptor.h"

@implementation DXHTTPParamKey

+ (NSArray *)allowedClassesForValueField {
    static NSArray *allowedClasses = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allowedClasses = @[[NSString class], [DXHTTPFormFileDescriptor class]];
    });
    return allowedClasses;
}

+ (BOOL)isAllowedClassForValueField:(Class)valueFieldClass {
    NSArray *allowedClasses = [self allowedClassesForValueField];
    for(int i = 0; i < [allowedClasses count]; ++i) {
        if([[valueFieldClass class] isSubclassOfClass:[allowedClasses[i] class]]) {
            return YES;
        }
    }
    return NO;
}
@end
