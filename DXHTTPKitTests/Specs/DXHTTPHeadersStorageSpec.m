#import "Kiwi.h"
#import "DXRequestParams.h"

SPEC_BEGIN(DXHTTPHeadersStorageSpec)

describe(@"Headers Storage", ^{
    
    __block DXHTTPHeadersStorage *headersStorage;
    
    context(@"right values", ^{
        
        beforeAll(^{
            headersStorage = [[DXHTTPHeadersStorage alloc] init];
        });
        
        it(@"Should keep header key and value", ^{
            [headersStorage addHeader:@"Host" value:@"localhost"];
            [[theValue([headersStorage.headers count]) should] equal:theValue(1)];
        });
        
        it(@"Should keep header multipile key and value", ^{
            [headersStorage addHeader:@"Cookies" value:@[@"login=111minutes", @"passwd=111min"]];
            [[theValue([headersStorage.headers count]) should] equal:theValue(2)];
        });
        
        it(@"Should keep header exists value and append new value", ^{
            [headersStorage addHeader:@"Cookies" value:@[@"userpath=/", @"projectsCount=5"]];
            NSArray *valueArray = [headersStorage.headers objectForKey:@"Cookies"];
            [[theValue([valueArray count]) should] isEqual:theValue(4)];
        });
    });
    
    context(@"invalid values", ^{
        
        beforeAll(^{
            headersStorage = [[DXHTTPHeadersStorage alloc] init];
        });
        
        it(@"Should throw exception in case of non string key type", ^{
            [[theBlock(^{
                [headersStorage addHeader:[NSData dataWithBytes:"123" length:3] value:@"header value"];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
        
        it(@"Should throw exception in case of non string value type", ^{
            [[theBlock(^{
                [headersStorage addHeader:@"key" value:[NSData dataWithBytes:"123" length:3]];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
        
        it(@"Should throw exception in case of nil key type", ^{
            [[theBlock(^{
                [headersStorage addHeader:nil value:@"value1"];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
        
        it(@"Should throw exception in case of empty string key type", ^{
            [[theBlock(^{
                [headersStorage addHeader:@"" value:@"value1"];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
        
        it(@"Should throw exception in case of nil value type", ^{
            [[theBlock(^{
                [headersStorage addHeader:@"key" value:nil];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
    });
    
    
});


SPEC_END