//
//  DXHTTPHeader.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPParamKey.h"

@interface DXHTTPHeadersStorage : DXHTTPParamKey

@property (nonatomic, strong, readonly) NSMutableDictionary *headers;

- (DXHTTPHeadersStorage *)initWithHeader:(NSString *)aKey value:(NSArray *)aValue;

- (void)addHeader:(NSString *)aHeaderKey value:(NSArray *)aValue;
@end
