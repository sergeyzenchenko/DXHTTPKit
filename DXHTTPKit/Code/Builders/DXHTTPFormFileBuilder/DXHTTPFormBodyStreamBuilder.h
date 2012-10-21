//
//  DXHTTPFormFileBuilder.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPRequestDescriptor.h"
#import "DXHTTPFormFileElement.h"

@interface DXHTTPFormBodyStreamBuilder : NSInputStream

- (id)initWithFiles:(NSArray *)aFilesArray andParamsArray:(NSArray *)aParamsArray;

- (void)buildStream;

@property (nonatomic, strong, readonly) NSString *boundary;
@property (nonatomic, readonly) NSUInteger length;

@end
