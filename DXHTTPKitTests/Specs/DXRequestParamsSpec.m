#import "Kiwi.h"
#import "DXRequestParams.h"

SPEC_BEGIN(DXRequestParamsSpec)

describe(@"RequestParams", ^{
    
    __block DXRequestParams *requestParams;
    
    context(@"right values", ^{
        beforeAll(^{
            requestParams  = [[DXRequestParams alloc] init];
        });
        
        it(@"Should set value", ^{
            [requestParams setPath:@"path"];
            [[theValue([requestParams path]) should] equal:theValue(@"path")];
        });
        
        it(@"Should accept value as httpMethod instance", ^{
            requestParams.httpMethod = DXHTTPMethod.POST;
            [[theValue(requestParams.httpMethod) should] equal:theValue(@"POST")];
        });
        it(@"Should accept string value as header value", ^{
            [requestParams addHeader:@"Header" value:@"value"];
            [[theValue([requestParams.headers count]) should] equal:theValue(1)];
        });
        it(@"Should accept array value as header value", ^{
            [requestParams addHeader:@"Header" value:@[@"value1", @"value2"]];
            [[theValue([requestParams.headers count]) should] equal:theValue(1)];
            
            NSArray *arr = [requestParams.headers objectForKey:@"Header"];
            [[theValue([arr count]) should] equal:theValue(3)];
        });
    });
    
    context(@"invalid values", ^{
        beforeAll(^{
            requestParams = [[DXRequestParams alloc] init];
        });
        
        it(@"Should throw an exception in case of invalid HTTP method value", ^{
            [[theBlock(^{
                [requestParams setHttpMethod:@"FOR"];
            }) should] raise];
        });
    });
    
});

SPEC_END