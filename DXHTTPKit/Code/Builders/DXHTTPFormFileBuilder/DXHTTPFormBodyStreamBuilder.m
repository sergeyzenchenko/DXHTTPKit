//
//  DXHTTPFormFileBuilder.m
//  DXHTTPKit
//
//  Created by TheSooth on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPFormBodyStreamBuilder.h"

@interface DXHTTPFormBodyStreamBuilder() {
    NSMutableArray *_parts;
    NSData         *_footer;
    NSUInteger     _footerLength, _currentPart, _length, _delivered, _status;
    NSString *_boundary;
    NSArray *_filesArray, *_paramsArray;
}

@end

@implementation DXHTTPFormBodyStreamBuilder

- (id)initWithFilesArrayAndParamsArray:(NSArray *)aFilesArray paramsArray:(NSArray *)aParamsArray {
    DXParametrAssert([aFilesArray count], @"Empty files Array");
    
    self = [super init];
    if (self) {
        _filesArray  = aFilesArray;
        _paramsArray = aParamsArray;
        _parts = [NSMutableArray new];
        _boundary = @"DXHTTPKit-abcdefg123";
        _footer = [[NSString stringWithFormat:@"--%@--\r\n", _boundary] dataUsingEncoding:NSUTF8StringEncoding];
        _footerLength = [_footer length];
        [self updateLength];
    }
    return self;
}

- (void)buildStream {
    for (DXHTTPFormParam *fileElement in _filesArray) {
        [_parts addObject:[[DXHTTPFormFileElement alloc] initWithFormFileParamAndBoundary:fileElement boundary:_boundary]];
        
        [self updateLength];
    }
    
    for (DXHTTPFormParam *paramElement in _paramsArray) {
        [_parts addObject:[[DXHTTPFormFileElement alloc] initWithFormParamAndBoundary:paramElement boundary:_boundary]];
        
        [self updateLength];
    }
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    NSUInteger sent = 0, read;
    
    _status = NSStreamStatusReading;
    while (_delivered < _length && sent < len && _currentPart < [_parts count])
    {
        if ((read = [_parts[_currentPart] read:buffer + sent maxLength:len - sent]) == 0)
        {
            _currentPart ++;
            continue;
        }
        sent      += read;
        _delivered += read;
    }
    if (_delivered >= (_length - _footerLength) && sent < len)
    {
        read       = min(_footerLength - (_delivered - (_length - _footerLength)), len - sent);
        [_footer getBytes:buffer + sent range:NSMakeRange(_delivered - (_length - _footerLength), read)];
        sent      += read;
        _delivered += read;
    }
    return sent;
}

- (BOOL)hasBytesAvailable {
    return _delivered < _length;
}

- (void)open {
    _status = NSStreamStatusOpen;
}

- (void)close {
    _status = NSStreamStatusClosed;
}

- (NSStreamStatus)streamStatus {
    if (_status != NSStreamStatusClosed && _delivered >= _length)
    {
        _status = NSStreamStatusAtEnd;
    }
    return _status;
}

- (void)updateLength
{
    _length     = _footerLength;
    for (DXHTTPFormFileElement *fe in _parts)
    {
        _length += [fe partLenght];
    }
}

- (NSUInteger)length {
    return _length;
}

- (NSString *)boundary {
    return _boundary;
}

- (void)_scheduleInCFRunLoop:(NSRunLoop *)runLoop forMode:(id)mode {}
- (void)_setCFClientFlags:(CFOptionFlags)flags callback:(CFReadStreamClientCallBack)callback context:(CFStreamClientContext)context {}
@end