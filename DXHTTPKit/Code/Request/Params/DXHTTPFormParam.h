//
//  DXHTTPFormParam.h
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPParam.h"

@interface DXHTTPFormParam : DXHTTPParam

@property (nonatomic, strong, readonly) id value;

- (id)initWithKey:(NSString *)aKey value:(id)aValue;

@end
