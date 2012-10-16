//
//  DXParam.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPFormParam.h"

@interface DXHTTPFormParam ()

@property (nonatomic, copy, readwrite) NSString *key;
@property (nonatomic, copy, readwrite) id value;

@end

@implementation DXHTTPFormParam

- (DXHTTPFormParam *)initWithKey:(NSString *)aKey value:(id)aValue {
    
    NSParameterAssert(aKey != nil);
    NSParameterAssert([aKey isKindOfClass:[NSString class]]);
    NSParameterAssert([DXHTTPFormParam isAllowedClassForValueField:[aValue class]]);
    
    self = [super init];
    if(self) {
        self.key = aKey;
        self.value = aValue;
    }
    return self;
}
@end
