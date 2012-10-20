//
//  DXHTTPFormFileBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormFileBuilder.h"

@implementation DXHTTPFormFileBuilder

- (NSInputStream *)buildFileStream:(DXHTTPFormFileDescriptor *)fileDescriptor {
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:[fileDescriptor filePath]];
    return inputStream;
}

@end
