#import "Kiwi.h"
#import "DXHTTPRequestDescriptor.h"

SPEC_BEGIN(DXRequestDescriptorSpec)

describe(@"DXRequestDescriptor", ^{
    
    __block DXHTTPRequestDescriptor *requestDescriptor;
    
    context(@"right values", ^{
        beforeAll(^{
            requestDescriptor  = [[DXHTTPRequestDescriptor alloc] init];
        });
        
        it(@"Should set value", ^{
            [requestDescriptor setPath:@"path"];
            [[theValue([requestDescriptor path]) should] equal:theValue(@"path")];
        });
        
        it(@"Should accept value as httpMethod instance", ^{
            requestDescriptor.httpMethod = DXHTTPMethod.POST;
            [[theValue(requestDescriptor.httpMethod) should] equal:theValue(@"POST")];
        });
        
        it(@"Should accept string value as header value", ^{
            [requestDescriptor addHeader:@"Header" value:@"value"];
            [[theValue([requestDescriptor.headers count]) should] equal:theValue(1)];
        });
        
        it(@"Should accept array value as header value", ^{
            [requestDescriptor addHeader:@"Header" value:@[@"value1", @"value2"]];
            [[theValue([requestDescriptor.headers count]) should] equal:theValue(1)];
            
            NSArray *arr = [requestDescriptor.headers objectForKey:@"Header"];
            [[theValue([arr count]) should] equal:theValue(3)];
        });
    });
    
    context(@"invalid values", ^{
        beforeAll(^{
            requestDescriptor = [[DXHTTPRequestDescriptor alloc] init];
        });
        
        it(@"Should throw an exception in case of invalid HTTP method value", ^{
            [[theBlock(^{
                [requestDescriptor setHttpMethod:@"FOR"];
            }) should] raise];
        });
    });
    
});

SPEC_END