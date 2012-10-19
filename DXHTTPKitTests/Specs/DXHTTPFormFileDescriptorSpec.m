#import "Kiwi.h"
#import "DXHTTPFormFileDescriptor.h"

SPEC_BEGIN(DXHTTPFormFileDescriptorSpec)

describe(@"DXHTTPFormFileDescriptor", ^{
    
    it(@"Should keep path of file", ^{
        DXHTTPFormFileDescriptor *file = [DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/var/log/zzz.log"];
        [[theValue(file.filePath) should] equal:theValue(@"/var/log/zzz.log")];
    });
    
});

SPEC_END