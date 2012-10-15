//
//  DXHTTPHeader.h
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPParamKey.h"

@interface DXHTTPHeader : DXHTTPParamKey

@property (nonatomic, copy, readonly) NSString *value;

- (id)initWithKey:(NSString *)aKey value:(NSString*)aValue;

- (void)appendString:(NSString*)aValue;

- (NSString*)buildField;

@end
