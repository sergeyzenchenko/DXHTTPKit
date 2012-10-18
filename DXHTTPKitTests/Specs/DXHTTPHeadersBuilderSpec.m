#import "Kiwi.h"
#import "DXHTTPHeadersBuilder.h"

SPEC_BEGIN(DXHTTPHeadersBuilderSpec)

context(@"DXHTTPHeadersBuilder", ^{
    __block DXHTTPHeadersStorage *headersStorage;
    __block DXHTTPHeadersBuilder *headersBuilder;
    __block NSURLRequest *urlRequest;
    
    beforeAll(^{
        headersStorage = [DXHTTPHeadersStorage new];
        headersBuilder = [DXHTTPHeadersBuilder new];
        urlRequest = [NSURLRequest new];
    });
    
    it(@"Should return URLRequest with header value", ^{
        [headersStorage addHeader:@"Cookies" value:@"login=111minutes"];
        
         urlRequest = [headersBuilder buildHeaders:headersStorage.headers urlRequest:urlRequest];
        [[[urlRequest valueForHTTPHeaderField:@"Cookies"] should] equal:@"login=111minutes"];
    });
    it(@"Should return URLRequest with multiplie header values", ^{
        [headersStorage addHeader:@"Cookies" value:@"passwd=111"];
        
        urlRequest = [headersBuilder buildHeaders:headersStorage.headers urlRequest:urlRequest];
        [[[urlRequest valueForHTTPHeaderField:@"Cookies"] should] equal:@"login=111minutes; passwd=111"];
    });
    it(@"Should return URLRequest with multipile headers", ^{
        [headersStorage addHeader:@"Host" value:@"localhost"];
        
        urlRequest = [headersBuilder buildHeaders:headersStorage.headers urlRequest:urlRequest];
        NSDictionary *urlRequestHeaders = [urlRequest allHTTPHeaderFields];
        
        [[[urlRequestHeaders objectForKey:@"Host"] should] equal:@"localhost"];
        [[theValue([urlRequestHeaders count]) should] equal:theValue(2)];
    });
});

SPEC_END