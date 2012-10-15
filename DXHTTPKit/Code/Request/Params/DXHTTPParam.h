//
//  DXHTTPParam.h
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXHTTPParam : NSObject

@property (nonatomic, copy, readonly) NSString *key;

- (id)initWithKey:(NSString*)aKey;

@end
