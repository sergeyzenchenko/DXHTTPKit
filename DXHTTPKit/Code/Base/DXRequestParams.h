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

extern const struct DXHTTPMethod
{
    __unsafe_unretained NSString *GET;
    __unsafe_unretained NSString *POST;
    __unsafe_unretained NSString *PUT;
    __unsafe_unretained NSString *DELETE;
    __unsafe_unretained NSString *HEAD;
    BOOL (*isValid)(NSString *method);
} DXHTTPMethod;

@interface DXRequestParams : DXHTTPParamKey

@property (nonatomic, strong, readonly) NSArray *params;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy) NSString *path;

- (void)addParam:(NSString *)key value:(id)value;

- (void)addHeader:(NSString *)aHeaderKey value:(NSArray *)aValue;
@end
