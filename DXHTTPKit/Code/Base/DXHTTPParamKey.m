//
//  DXHTTPParam.m
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPParamKey.h"

@interface DXHTTPParamKey ()

@property (nonatomic, copy, readwrite) NSString *key;

@end

@implementation DXHTTPParamKey

- (id)initWithKey:(NSString*)aKey
{
    NSParameterAssert(aKey != nil);
    NSParameterAssert([aKey isKindOfClass:[NSString class]]);
    
    self = [super init];
    if (self) {
        self.key = aKey;
    }
    return self;
}

@end
