#import "Kiwi.h"
#import "DXHTTPRequestBuilder.h"
#import "DXHTTPFormParamsBuilder.h"

SPEC_BEGIN(DXHTTPFormFileBuilderSpec)

describe(@"DXHTTPFormFileBuilder", ^{
   
    it(@"Should a return input stream", ^{
        DXHTTPRequestDescriptor *requestDescriptor = [DXHTTPRequestDescriptor new];
        [requestDescriptor addParam:@"userfile" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/etc/hosts"]];
        [requestDescriptor setHttpMethod:DXHTTPMethod.POST];
        NSURLRequest *urlRequest = [NSURLRequest new];
        urlRequest = [[DXHTTPURLRequestAdditionalsBuilder alloc] buildAdditionals:requestDescriptor];
        urlRequest = [[DXHTTPFormParamsBuilder alloc] buildParams:requestDescriptor urlRequest:urlRequest];
        
        [[[urlRequest HTTPBodyStream] should] beNonNil];
        
    });
});

SPEC_END