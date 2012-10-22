#import "Kiwi.h"
#import "DXHTTPRequestBuilder.h"
#import "DXHTTPFormParamsBuilder.h"


SPEC_BEGIN(DXHTTPFormBodyStreamBuilderSpec)

    __block NSString *fileName = @"/etc/hosts";
    __block NSString *boundary = [NSString stringWithFormat:@"DXHTTPKit-%@", [[NSProcessInfo processInfo] hostName]];
    __block DXHTTPRequestDescriptor *requestDescriptor;
    __block NSMutableData *testBodyData;
    __block NSMutableURLRequest *urlRequest;
    __block NSMutableData *streamData;
    __block NSUInteger bytesRead;
    __block unsigned int len;

describe(@"DXHTTPFormBodyStreamBuilder", ^{
    
    beforeEach(^{
        bytesRead = 0;
        len = 0;
        testBodyData = [NSMutableData new];
        urlRequest = [NSMutableURLRequest new];
        streamData = [[NSMutableData alloc] init];
        requestDescriptor = [DXHTTPRequestDescriptor new];
    });
    
    it(@"Should a return input stream", ^{
        NSString *testHeaderPart = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n", boundary, [fileName lastPathComponent]];
        NSData *testFileData = [NSData dataWithContentsOfFile:fileName];
        NSString *testFooterPart = [NSString stringWithFormat:@"\r\n--%@--\r\n", boundary];
        
        [testBodyData appendData:[testHeaderPart dataUsingEncoding:NSUTF8StringEncoding]];
        [testBodyData appendData:testFileData];
        [testBodyData appendData:[testFooterPart dataUsingEncoding:NSUTF8StringEncoding]];
        
        [requestDescriptor addParam:@"userfile" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:fileName]];
        [requestDescriptor setHttpMethod:DXHTTPMethod.POST];
        
        [urlRequest setHTTPMethod:DXHTTPMethod.POST];
        urlRequest = [[[DXHTTPFormParamsBuilder alloc] buildParams:requestDescriptor urlRequest:[urlRequest copy]] mutableCopy];
        
        NSInputStream *bodyStream = [urlRequest HTTPBodyStream];
        [bodyStream open];
        
        uint8_t buf[4096];
        len = [(NSInputStream *)bodyStream read:buf maxLength:4096];
        if(len) {
            [streamData appendBytes:(const void *)buf length:len];
            bytesRead += len;
        }
        
        [[streamData should] equal:testBodyData];
    });
    it(@"Should a return input stream with file and param in body stream", ^{
        NSString *testFileHeaderPart = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n", boundary, [fileName lastPathComponent]];
        NSData *testFileData = [NSData dataWithContentsOfFile:fileName];
        NSMutableData *testBodyData  = [NSMutableData new];
        
        NSData *paramPart = [[NSString stringWithFormat:@"\r\n--%@\r\nContent-Disposition: form-data; name=\"someParam\"\r\n\r\nsomeValue\r\n--%@--\r\n", boundary, boundary] dataUsingEncoding:NSUTF8StringEncoding];
        
        [testBodyData appendData:[testFileHeaderPart dataUsingEncoding:NSUTF8StringEncoding]];
        [testBodyData appendData:testFileData];
        [testBodyData appendData:paramPart];
        
        [requestDescriptor addParam:@"userfile" value:[DXHTTPFormFileDescriptor fileDescriptorWithPath:fileName]];
        [requestDescriptor addParam:@"someParam" value:@"someValue"];
        [requestDescriptor setHttpMethod:DXHTTPMethod.POST];
        
        [urlRequest setHTTPMethod:DXHTTPMethod.POST];
        urlRequest = [[[DXHTTPFormParamsBuilder alloc] buildParams:requestDescriptor urlRequest:[urlRequest copy]] mutableCopy];
        
        NSInputStream *bodyStream = [urlRequest HTTPBodyStream];
        [bodyStream open];
        
        uint8_t buf[4096];
        len = [(NSInputStream *)bodyStream read:buf maxLength:4096];
        if(len) {
            [streamData appendBytes:(const void *)buf length:len];
            bytesRead += len;
        }
        
        [[streamData should] equal:testBodyData];
        
    });
});

SPEC_END