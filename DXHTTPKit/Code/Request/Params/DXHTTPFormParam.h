//
//  DXHTTPFormParam.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPParamKey.h"

@interface DXHTTPFormParam : DXHTTPParamKey

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) id value;

- (id)initWithKey:(NSString *)aKey value:(id)aValue;
- (NSString *)description;

@end
