//
//  DXHTTPErrors.h
//  DXHTTPKit
//
//  Created by TheSooth on 10/18/12.
//  Copyright (c) 2012 111Minutes. All rights reserved.
//

#import "DXHTTPKitErrors.h"

const struct DXHTTPKitErrors DXHTTPKitErrors = {
    .HTTPInvalidMethod = @"Invalid HTTP Method",
    .HTTPMethodIsEmpty = @"HTTP Method is Empty",
    .FilesOnNonPostMethod = @"You can using files only in POST HTTP Method",
    .EmptyBaseURL = @"Base URL cannot be empty",
};
