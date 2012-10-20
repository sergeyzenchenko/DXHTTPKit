//
//  DXHTTPFormFileElement.h
//  DXHTTPKit
//
//  Created by dev2 on 10/20/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXHTTPRequestDescriptor.h"

@interface DXHTTPFormFileElement : NSObject {
    NSData *partHeader;
    NSInputStream *partBody;
    NSUInteger partBodyLength, partHeaderLength, partLenght;
}

- (id)initWithFormParamAndBoundary:(DXHTTPFormParam *)formParam  boundary:(NSString *)boundary;

@end
