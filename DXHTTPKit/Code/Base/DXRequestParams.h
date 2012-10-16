//
//  DXRequestParams.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPFormParam.h"
#import "DXHTTPHeadersStorage.h"
#import "DXHTTPFormFileDescriptor.h"

@interface DXRequestParams : DXHTTPParamKey

@property (nonatomic, readonly) NSMutableArray *params;
@property (nonatomic, readonly) DXHTTPHeadersStorage *headersStorage;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy) NSString *path;

- (void)addParam:(NSString *)key value:(id)value;

- (void)addHeader:(NSString *)aHeaderKey value:(NSArray *)aValue;
@end
