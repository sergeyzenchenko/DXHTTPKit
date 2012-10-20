#import "Kiwi.h"
#import "DXHTTPFormFileBuilder.h"

SPEC_BEGIN(DXHTTPFormFileBuilderSpec)

describe(@"DXHTTPFormFileBuilder", ^{
   
    it(@"Should a return input stream", ^{
        DXHTTPFormFileBuilder *fileBuilder = [DXHTTPFormFileBuilder new];
        DXHTTPFormFileDescriptor *fd = [DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/var/log/kernel.log"];
        NSInputStream *fileStream = [fileBuilder buildFileStream:fd];
        [[fileStream should] beNonNil];
    });
});

SPEC_END