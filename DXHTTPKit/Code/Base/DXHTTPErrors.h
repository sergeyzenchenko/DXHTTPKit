//
//  DXHTTPErrors.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/18/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

static const struct DXHTTPErrors
{
    __unsafe_unretained NSString *HTTPInvalidMethod;
    __unsafe_unretained NSString *HTTPMethodIsEmpty;
} DXHTTPErrors;

static const struct DXHTTPErrors DXHTTPErrors = {
    .HTTPInvalidMethod = @"Invalid HTTP Method",
    .HTTPMethodIsEmpty = @"HTTP Method is Empty",
};
