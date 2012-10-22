#import "Kiwi.h"
#import "DXHTTPFormParamsBuilder.h"
#import "DXHTTPRequestDescriptor.h"
#import "DXHTTPURLRequestAdditionalsBuilder.h"

SPEC_BEGIN(DXHTTPFormParamsBuilderSpec)

describe(@"DXHTTPFormParamsBuilder", ^{
    
    __block DXHTTPFormParamsBuilder *paramsBuilder;
    __block NSURLRequest *urlRequest;
    __block DXHTTPRequestDescriptor *requestDescriptor;
    
    beforeEach(^{
        paramsBuilder = [DXHTTPFormParamsBuilder new];
        requestDescriptor = [DXHTTPRequestDescriptor new];
        urlRequest = [[NSURLRequest alloc] init];
    });
    
    context(@"right values", ^{
        
        it(@"Should return urlRequest with builded url", ^{
            [requestDescriptor setBaseURL:@"http://localhost"];
            [requestDescriptor addParam:@"login" value:@"111minutes"];
            [requestDescriptor setHttpMethod:DXHTTPMethod.GET];
            
            urlRequest = [paramsBuilder buildParams:requestDescriptor urlRequest:urlRequest];
            
            [[[[urlRequest URL] absoluteString] should] equal:@"(null)?login=111minutes"];
        });
        
        it(@"Should return urlRequest with multipile params in url", ^{
            [requestDescriptor addParam:@"login" value:@"111minutes"];
            [requestDescriptor addParam:@"passwd" value:@"111"];
            [requestDescriptor setHttpMethod:DXHTTPMethod.GET];
            
            urlRequest = [paramsBuilder buildParams:requestDescriptor urlRequest:urlRequest];
            
            [[[[urlRequest URL] absoluteString] should] equal:@"(null)?login=111minutes&passwd=111"];
        });
        
        it(@"Should return urlRequest bodyStream", ^{
            NSMutableURLRequest *mutableURLRequest = [NSMutableURLRequest new];
            [requestDescriptor addParam:@"login" value:@"111minutes"];
            [requestDescriptor addParam:@"file" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/var/log/system.log"]];
            [mutableURLRequest setHTTPMethod:DXHTTPMethod.POST];
            
            mutableURLRequest = [[paramsBuilder buildParams:requestDescriptor urlRequest:mutableURLRequest] mutableCopy];
            
            [[[mutableURLRequest HTTPBodyStream] should] beNonNil];
        });
        
        it(@"Should return urlRequest, url must be without FileDescriptor", ^{
            [requestDescriptor addParam:@"login" value:@"111minutes"];
            [requestDescriptor addParam:@"passwd" value:@"111"];
            [requestDescriptor setHttpMethod:DXHTTPMethod.GET];
            
            urlRequest = [paramsBuilder buildParams:requestDescriptor urlRequest:urlRequest];
            
            [[[[urlRequest URL] absoluteString] should] equal:@"(null)?login=111minutes&passwd=111"];
        });
    });
    
    context(@"invalid values", ^{
        it(@"Should throw exception in case of using files in GET method", ^{
            [[theBlock(^{
                [requestDescriptor addParam:@"file" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/etc/hosts"]];
                urlRequest = [paramsBuilder buildParams:requestDescriptor urlRequest:urlRequest];
            }) should] raiseWithName:DXHTTPKitErrors.FilesOnNonPostMethod];
        });
    });
});

SPEC_END