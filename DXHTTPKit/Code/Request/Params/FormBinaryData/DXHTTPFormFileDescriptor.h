//
//  DXFile.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXHTTPFormFileDescriptor : NSObject <NSCopying>

@property (nonatomic, copy, readonly) NSString *filePath;

- (DXHTTPFormFileDescriptor *)initWithFilePath:(NSString *)filePath;

+ (DXHTTPFormFileDescriptor *)fileDescriptorWithPath:(NSString *)pathToFile;

@end
