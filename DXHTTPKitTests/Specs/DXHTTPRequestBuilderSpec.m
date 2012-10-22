#import "Kiwi.h"
#import "DXHTTPRequestBuilder.h"
#import "DXHTTPFormFileDescriptor.h"

SPEC_BEGIN(DXHTTPRequestBuilderSpec);

describe(@"DXHTTPRequestBuilder", ^{
    __block DXHTTPRequestBuilder *requestBuilder;
    __block DXHTTPRequestDescriptor *requestDescriptor;
    __block NSURLRequest *urlRequest;
    
    beforeEach(^{
        requestDescriptor = [DXHTTPRequestDescriptor new];
        requestBuilder = [DXHTTPRequestBuilder new];
        urlRequest = [NSURLRequest new];
    });
    
    it(@"Should return HTTPBodyStream with params", ^{
        NSString *boundary = [NSString stringWithFormat:@"DXHTTPKit-%@", [[NSProcessInfo processInfo] hostName]];
        
        [requestDescriptor addParam:@"someParam" value:@"someValue"];
        [requestDescriptor setHttpMethod:DXHTTPMethod.POST];
        [requestDescriptor setBaseURL:@"http://localhost"];
        
        NSData *testData = [[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"someParam\"\r\n\r\nsomeValue\r\n--%@--\r\n", boundary, boundary] dataUsingEncoding:NSUTF8StringEncoding];
        
        urlRequest = [requestBuilder buildRequest:requestDescriptor];
        NSInputStream *bodyStream = [urlRequest HTTPBodyStream];
        [bodyStream open];
        
        NSMutableData *streamData = [[NSMutableData alloc] init];
        NSUInteger bytesRead = 0 ;
        
        uint8_t buf[1024];
        unsigned int len = 0;
        len = [(NSInputStream *)bodyStream read:buf maxLength:1024];
        if(len) {
            [streamData appendBytes:(const void *)buf length:len];
            bytesRead += len;
        }
        [[streamData should] equal:testData];
       
    });
    it(@"Should return URLRequest with params in URL", ^{
        [requestDescriptor addParam:@"someParam" value:@"someValue"];
        
        [requestDescriptor addHeader:@"Cookies" value:@[@"login=111minutes", @"passwd=111min"]];
        
        [requestDescriptor setHttpMethod:DXHTTPMethod.GET];
        
        [requestDescriptor setBaseURL:@"http://localhost"];
        [requestDescriptor setPath:@"/~thesooth/upload.php"];
        [requestDescriptor setTimeOutInterval:10];
        
        urlRequest = [[DXHTTPURLRequestAdditionalsBuilder alloc] buildAdditionals:requestDescriptor];
        
        urlRequest = [requestBuilder buildRequest:requestDescriptor];
        
        [[[[urlRequest URL] absoluteString] should] equal:@"http://localhost/~thesooth/upload.php?someParam=someValue"];
    });
});

SPEC_END
