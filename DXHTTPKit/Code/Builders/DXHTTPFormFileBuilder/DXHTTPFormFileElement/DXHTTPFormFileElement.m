//
//  DXHTTPFormFileElement.m
//  DXHTTPKit
//
//  Created by dev2 on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormFileElement.h"

@implementation DXHTTPFormFileElement

- (id)initWithFormParamAndBoundary:(DXHTTPFormParam *)formParam  boundary:(NSString *)boundary {
    self = [super init];
    if (self) {
        NSString *filePath = [formParam.value filePath];
        partHeader = [[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",
                         [NSString stringWithFormat:@"DXHTTPKit-%@-%@", formParam.key,[filePath lastPathComponent]],
                         formParam.key,
                         [filePath lastPathComponent],
                         @"Mime-Type"] dataUsingEncoding:NSUTF8StringEncoding];
        partBody = [NSInputStream inputStreamWithFileAtPath:filePath];
        
        partHeaderLength = [partHeader length];
        partBodyLength = [[[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL] objectForKey:NSFileSize] unsignedIntegerValue];
        
        [self updatePartLength];
    }
    return self;
}

- (void)updatePartLength {
    partLenght = partHeaderLength + partBodyLength + 2;
    [partBody open];
}

@end
