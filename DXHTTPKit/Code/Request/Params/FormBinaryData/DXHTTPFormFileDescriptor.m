//
//  DXFile.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/14/12.
//  Copyright (c) 2012 TheSooth. All rights reserved.
//

#import "DXHTTPFormFileDescriptor.h"

@interface DXHTTPFormFileDescriptor()

@property (nonatomic, copy, readwrite) NSString *filePath;

@end

@implementation DXHTTPFormFileDescriptor

- (id)initWithFilePath:(NSString *)aFilePath {
    DXParametrAssert([[NSFileManager defaultManager] fileExistsAtPath:aFilePath], @"no file");
    
    self = [super init];
    if(self) {
        self.filePath = aFilePath;
    }
    return self;
}

+ (id)fileDescriptorWithPath:(NSString *)aFilePath {
    return [[DXHTTPFormFileDescriptor alloc] initWithFilePath:aFilePath];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        [copy setFilePath:self.filePath];
    }
    
    return copy;
}


@end
