#import "Kiwi.h"
#import "DXHTTPFormParam.h"
#import "DXHTTPFormFileDescriptor.h"

SPEC_BEGIN(DXHTTPFormParamSpec)

describe(@"DXFormParam", ^{
    
    __block DXHTTPFormParam *formParam;
    
    beforeEach(^{
        formParam = nil;
    });
    
    context(@"Right formParams", ^{
        NSString *stringKey = @"key";
        NSString *stringValue = @"value";
        
        
        it(@"Should accept key as NSString instance", ^{
            [[theBlock(^{
                formParam = [[DXHTTPFormParam alloc] initWithKey:stringKey value:stringValue];
            }) shouldNot] raise];
            
            [[formParam.key should] equal:stringKey];
        });
        
        it(@"Should accept value as NSString instance", ^{
            [[theBlock(^{
                formParam = [[DXHTTPFormParam alloc] initWithKey:stringKey value:stringValue];
            }) shouldNot] raise];
            [[formParam.value should] equal:stringValue];
        });
        
        it(@"Should accept value as file desciptor instance", ^{
            DXHTTPFormFileDescriptor *fileDescriptor = [DXHTTPFormFileDescriptor fileDescriptorWithPath:@"/var/log/kernel.log"];
            [[theBlock(^{
                formParam = [[DXHTTPFormParam alloc] initWithKey:stringKey value:fileDescriptor];
            }) shouldNot] raise];
        });
    });
    
    context(@"Wrong formParams", ^{
        
        it(@"Should throw an exception in case of invalid value class", ^{
            [[theBlock(^{
                formParam = [[DXHTTPFormParam alloc] initWithKey:@"key" value:@[]];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
        it(@"Should throw an exception in case of nil value class", ^{
            [[theBlock(^{
                formParam = [[DXHTTPFormParam alloc] initWithKey:@"key" value:nil];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
    });
});

SPEC_END