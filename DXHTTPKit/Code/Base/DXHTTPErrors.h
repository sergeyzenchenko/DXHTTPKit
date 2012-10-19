//
//  DXHTTPErrors.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/18/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

extern const struct DXHTTPErrors
{
    __unsafe_unretained NSString *HTTPInvalidMethod;
} DXHTTPErrors;

const struct DXHTTPErrors DXHTTPErrors = {
    .HTTPInvalidMethod = @"Invalid HTTP Method",
};
