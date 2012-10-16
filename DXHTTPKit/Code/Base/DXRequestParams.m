//
//  DXRequestParams.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXRequestParams.h"

@interface DXRequestParams() {
    NSArray *_allowedRequestsList;
}
@property (nonatomic, readwrite) NSMutableArray *params;
@property (nonatomic, readwrite) DXHTTPHeadersStorage *headersStorage;
@end

@implementation DXRequestParams

- (DXRequestParams *)init {
    self = [super init];
    if(self) {
        self.params = [[NSMutableArray alloc] init];
        self.headersStorage = [[DXHTTPHeadersStorage alloc] init];
        _allowedRequestsList = @[@"GET", @"POST", @"PUT", @"DELETE", @"HEAD"];
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
    NSParameterAssert([_allowedRequestsList containsObject:aHttpMethod]);
    
    _httpMethod = aHttpMethod;
}
@end
