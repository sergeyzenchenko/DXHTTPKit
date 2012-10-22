//
//  DXHTTPFormFileElement.m
//  DXHTTPKit
//
//  Created by dev2 on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormPartElement.h"

@interface DXHTTPFormPartElement() {
    NSData *_partHeader;
    NSInputStream *_partBody;
    NSUInteger _partBodyLength, _partHeaderLength, _partLenght, _delivered;
}
@end

@implementation DXHTTPFormPartElement

- (id)initWithFormFileParam:(DXHTTPFormParam *)fileParam  boundary:(NSString *)boundary {
    self = [super init];
    if (self) {
        NSString *filePath = [fileParam.value filePath];
        _partHeader = [[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n\r\n",
                        boundary,
                        fileParam.key,
                        [filePath lastPathComponent],
                        [self mimeTypeForFileAtPath:filePath]] dataUsingEncoding:NSUTF8StringEncoding];
        _partBody = [NSInputStream inputStreamWithFileAtPath:filePath];
        
        _partHeaderLength = [_partHeader length];
        _partBodyLength = [[[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL] objectForKey:NSFileSize] unsignedIntegerValue];
        
        [self updatePartLength];
    }
    return self;
}

- (id)initWithFormParam:(DXHTTPFormParam *)formParam boundary:(NSString *)boundary {
    self = [super init];
    if (self) {
        _partHeader = [[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n", boundary, formParam.key] dataUsingEncoding:NSUTF8StringEncoding];
        _partBody = [NSInputStream inputStreamWithData:[formParam.value dataUsingEncoding:NSUTF8StringEncoding]];
        _partHeaderLength = [_partHeader length];
        _partBodyLength = [[formParam.value dataUsingEncoding:NSUTF8StringEncoding] length];
        
        [self updatePartLength];
    }
    return self;
}


- (NSUInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    NSUInteger sent = 0, read;
    
    if (_delivered >= _partLenght)
    {
        return 0;
    }
    if (_delivered < _partHeaderLength && sent < len)
    {
        read       = min(_partHeaderLength - _delivered, len - sent);
        [_partHeader getBytes:buffer + sent range:NSMakeRange(_delivered, read)];
        sent      += read;
        _delivered += sent;
    }
    while (_delivered >= _partHeaderLength && _delivered < (_partLenght - 2) && sent < len)
    {
        if ((read = [_partBody read:buffer + sent maxLength:len - sent]) == 0)
        {
            break;
        }
        sent      += read;
        _delivered += read;
    }
    if (_delivered >= (_partLenght - 2) && sent < len)
    {
        if (_delivered == (_partLenght - 2))
        {
            *(buffer + sent) = '\r';
            sent ++; _delivered ++;
        }
        *(buffer + sent) = '\n';
        sent ++; _delivered ++;
    }
    return sent;
}

- (void)updatePartLength {
    _partLenght = _partHeaderLength + _partBodyLength + 2;
    [_partBody open];
}

- (NSUInteger)partLenght {
    return _partLenght;
}

- (NSString *) mimeTypeForFileAtPath: (NSString *) path {
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    
    if (!mimeType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)mimeType;
}

@end
