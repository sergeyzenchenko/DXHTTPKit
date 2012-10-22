#import "Kiwi.h"
#import "DXHTTPFormFileDescriptor.h"

SPEC_BEGIN(DXHTTPFormFileDescriptorSpec)

describe(@"DXHTTPFormFileDescriptor", ^{
    
    it(@"Should keep path of file", ^{
        DXHTTPFormFileDescriptor *file = [DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/var/log/system.log"];
        [[theValue(file.filePath) should] equal:theValue(@"/var/log/system.log")];
    });
});

SPEC_END