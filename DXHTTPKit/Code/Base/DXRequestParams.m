//
//  DXRequestParams.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXRequestParams.h"

static BOOL HTTPMethodIsValid(NSString *method)
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
    .isValid = HTTPMethodIsValid
};

@interface DXRequestParams()

@property (nonatomic, readwrite) NSMutableArray *params;
@property (nonatomic, readwrite) DXHTTPHeadersStorage *headersStorage;
@end

@implementation DXRequestParams


- (id)init {
    self = [super init];
    if(self) {
        self.params = [[NSMutableArray alloc] init];
        self.headersStorage = [[DXHTTPHeadersStorage alloc] init];
    }
    return self;
}

- (void)addParam:(NSString *)key value:(id)value {
    DXHTTPFormParam *param = [[DXHTTPFormParam alloc] initWithKey: key value:value];
    
    [self.params addObject:param];
}


- (void)addHeader:(NSString *)aHeaderKey value:(NSArray *)aValue {
    [self.headersStorage addHeader:aHeaderKey value:aValue];
}

- (void)setHttpMethod:(NSString *)aHttpMethod {
    
    DXParametrAssert(HTTPMethodIsValid(aHttpMethod), @"Invalid HTTP Method");

        _httpMethod = aHttpMethod;
}
@end
