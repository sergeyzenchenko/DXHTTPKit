//
//  DXHTTPRequestDescriptor.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPRequestDescriptor.h"

static BOOL DXHTTPMethodIsValid(NSString *method)
{
    static const int numberOfMethods = 5;
    NSString *methods[numberOfMethods] = {
        DXHTTPMethod.GET,
        DXHTTPMethod.POST,
        DXHTTPMethod.PUT,
        DXHTTPMethod.DELETE,
        DXHTTPMethod.HEAD
    };
    for (int i = 0 ; i < numberOfMethods; i++) {
        if (methods[i] == method) {
            return YES;
        }
    }
    return NO;
}

const struct DXHTTPMethod DXHTTPMethod = {
    .GET = @"GET",
    .POST = @"POST",
    .PUT = @"PUT",
    .DELETE = @"DELETE",
    .HEAD = @"HEAD",
    .isValid = DXHTTPMethodIsValid
};

@interface DXHTTPRequestDescriptor() {
     NSMutableArray *_params;
}
@property (nonatomic, readwrite) DXHTTPHeadersStorage *headersStorage;
@end

@implementation DXHTTPRequestDescriptor


- (id)init {
    self = [super init];
    if(self) {
        _params = [[NSMutableArray alloc] init];
        self.headersStorage = [[DXHTTPHeadersStorage alloc] init];
    }
    return self;
}

- (void)addParam:(NSString *)key value:(id)value {
    DXHTTPFormParam *param = [[DXHTTPFormParam alloc] initWithKey: key value:value];
    
    [_params addObject:param];
}


- (void)addHeader:(NSString *)aHeaderKey value:(id)aValue {
    [self.headersStorage addHeader:aHeaderKey value:aValue];
}

- (void)setHttpMethod:(NSString *)aHttpMethod {
    
    DXParametrAssert(DXHTTPMethodIsValid(aHttpMethod), DXHTTPKitErrors.HTTPInvalidMethod);
    
    _httpMethod = aHttpMethod;
}

- (NSArray*) params {
    return [_params copy];
}

- (NSDictionary *) headers {
    return [_headersStorage.headers copy];
}
@end
