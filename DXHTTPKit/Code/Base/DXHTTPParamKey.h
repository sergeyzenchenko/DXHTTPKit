//
//  DXParam.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXHTTPParamKey : NSObject

+ (NSArray *)allowedClassesForValueField;

+ (BOOL)isAllowedClassForValueField:(Class)valueFieldClass;
@end
