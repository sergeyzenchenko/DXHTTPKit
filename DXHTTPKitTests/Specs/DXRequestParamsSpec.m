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