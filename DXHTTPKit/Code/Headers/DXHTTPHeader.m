//
//  DXHTTPHeader.m
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPHeader.h"

@interface DXHTTPHeader ()

@property (nonatomic, copy, readwrite) NSString *value;

@end

@implementation DXHTTPHeader

- (id)initWithKey:(NSString *)aKey value:(NSString*)aValue
{
    NSParameterAssert([aValue isKindOfClass:[NSString class]]);
    self = [super initWithKey:aKey];
    if (self) {
        self.value = aValue;
    }
    return self;
}

- (void)appendString:(NSString*)aValue
{
    NSParameterAssert([aValue isKindOfClass:[NSString class]]);
    
    self.value = [self.value stringByAppendingFormat:@"%@", aValue];
}

- (NSString*)buildField
{
    return [NSString stringWithFormat:@"%@:%@", self.key, self.value];
}

@end
