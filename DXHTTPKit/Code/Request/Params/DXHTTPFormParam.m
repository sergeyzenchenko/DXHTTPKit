//
//  DXHTTPFormParam.m
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormParam.h"
#import "DXHTTPFormBinaryDataValue.h"

@interface DXHTTPFormParam ()

@property (nonatomic, strong, readwrite) id value;

@end

@implementation DXHTTPFormParam

- (id)initWithKey:(NSString *)aKey value:(id)aValue
{
    NSParameterAssert(aValue == nil || [aValue isKindOfClass:[NSString class]] || [aValue conformsToProtocol:@protocol(DXHTTPFormBinaryDataValue)]);
    
    self = [super initWithKey:aKey];
    if (self) {
        self.value = aValue;
    }
    return self;
}

@end
