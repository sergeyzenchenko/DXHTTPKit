//
//  DXHTTPParamKey.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXHTTPParamKey : NSObject

+ (NSArray *)allowedClassesForParamValueField;

+ (BOOL)isAllowedClassForParamValueField:(Class)valueFieldClass;

+ (NSArray *)allowedClassesForHeaderValueField;

+ (BOOL)isAllowedClassForHeaderValueField:(Class)valueFieldClass;
@end
