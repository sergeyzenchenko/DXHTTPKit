#import "Kiwi.h"
#import "DXHTTPRequestBuilder.h"
#import "DXHTTPFormFileDescriptor.h"

SPEC_BEGIN(DXHTTPRequestBuilderSpec);

describe(@"DXHTTPRequestBuilder", ^{
    it(@"Should connect with local webServer and upload file!", ^{
        DXHTTPRequestBuilder *requestBuilder = [DXHTTPRequestBuilder new];
        DXHTTPRequestDescriptor *requestDescriptor = [DXHTTPRequestDescriptor new];
        
        [requestDescriptor addParam:@"userfile" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/etc/hosts"]];
        [requestDescriptor addParam:@"someParam" value:@"someValue"];
        
        [requestDescriptor addHeader:@"Cookies" value:@[@"login=111minutes", @"passwd=111min"]];
        
        [requestDescriptor setHttpMethod:DXHTTPMethod.POST];
        
        [requestDescriptor setBaseURL:@"http://localhost"];
        [requestDescriptor setPath:@"/~thesooth/upload.php"];
        [requestDescriptor setTimeOutInterval:10];
        
        NSURLRequest *urlRequest = [requestBuilder buildRequest:requestDescriptor];
        
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        [connection start];
    });
    it(@"Should connect with local webServer and transmit value of param", ^{
        DXHTTPRequestBuilder *requestBuilder = [DXHTTPRequestBuilder new];
        DXHTTPRequestDescriptor *requestDescriptor = [DXHTTPRequestDescriptor new];
        
        [requestDescriptor addParam:@"userfile" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/etc/hosts"]];
        [requestDescriptor addParam:@"someParam" value:@"someValue"];
        
        [requestDescriptor addHeader:@"Cookies" value:@[@"login=111minutes", @"passwd=111min"]];
        
        [requestDescriptor setHttpMethod:DXHTTPMethod.GET];
        
        [requestDescriptor setBaseURL:@"http://localhost"];
        [requestDescriptor setPath:@"/~thesooth/upload.php"];
        [requestDescriptor setTimeOutInterval:10];
        
        NSURLRequest *urlRequest = [NSURLRequest new];
        
        urlRequest = [[DXHTTPURLRequestAdditionalsBuilder alloc] buildAdditionals:requestDescriptor];
        
        urlRequest = [requestBuilder buildRequest:requestDescriptor];
        
        [[[[urlRequest URL] absoluteString] should] equal:@"http://localhost/~thesooth/upload.php?someParam=someValue"];
        
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        [connection start];
    });
});

SPEC_END
