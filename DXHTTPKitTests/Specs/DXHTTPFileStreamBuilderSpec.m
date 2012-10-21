#import "Kiwi.h"
#import "DXHTTPRequestBuilder.h"
#import "DXHTTPFormParamsBuilder.h"

SPEC_BEGIN(DXHTTPFormFileBuilderSpec)

describe(@"DXHTTPFormFileBuilder", ^{
   
    it(@"Should a return input stream", ^{
        NSString *fileName = @"/etc/hosts";
        DXHTTPRequestDescriptor *requestDescriptor = [DXHTTPRequestDescriptor new];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest new];
        NSString *boundary = [NSString stringWithFormat:@"DXHTTPKit-%@", [[NSProcessInfo processInfo] hostName]];
        NSString *testHeaderPart = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n", boundary, [fileName lastPathComponent]];
        NSData *testFileData = [NSData dataWithContentsOfFile:fileName];
        NSMutableData *testBodyData  = [NSMutableData new];
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
        
        NSMutableData *streamData = [[NSMutableData alloc] init];
        NSUInteger bytesRead = 0 ;
        
        uint8_t buf[4096];
        unsigned int len = 0;
        len = [(NSInputStream *)bodyStream read:buf maxLength:4096];
        if(len) {
            [streamData appendBytes:(const void *)buf length:len];
            bytesRead += len;
        }

        [[streamData should] equal:testBodyData];
        
    });
});

SPEC_END