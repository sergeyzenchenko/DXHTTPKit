//
//  DXHTTPHeadersSpec.m
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXHTTPHeader.h"

SPEC_BEGIN(DXHTTPHeadersSpec)

describe(@"Headers", ^{
    NSString *testKey = @"testKey";
    NSString *testValue = @"testValue";
    
    it(@"Should init and kepp header value and key", ^{
        DXHTTPHeader *header = [[DXHTTPHeader alloc] initWithKey:testKey value:testValue];
        
        [[header.key should] equal:testKey];
        [[header.value should] equal:testValue];
    });
    
    it(@"Should append value", ^{
        DXHTTPHeader *header = [[DXHTTPHeader alloc] initWithKey:testKey value:testValue];
        
        NSString *suffix = @"suffix";
        
        [header appendString:suffix];
        
        [[header.key should] equal:testKey];
        [[header.value should] equal:[testValue stringByAppendingString:suffix]];
    });
    
    it(@"Should accept only value with type string", ^{
        [[theBlock(^{
            DXHTTPHeader *header __attribute__((unused)) = [[DXHTTPHeader alloc] initWithKey:testKey value:(NSString*)@[]];
        }) should] raiseWithName:NSInternalInconsistencyException];
        
        [[theBlock(^{
            DXHTTPHeader *header = [[DXHTTPHeader alloc] initWithKey:testKey value:testValue];
            
            [header appendString:(NSString*)@[]];
            
        }) should] raiseWithName:NSInternalInconsistencyException];
    });
    
    it(@"Should build right header field", ^{
        DXHTTPHeader *header = [[DXHTTPHeader alloc] initWithKey:testKey value:testValue];
        
        NSString *headerValue = [header buildField];
        
        [[headerValue should] equal:[NSString stringWithFormat:@"%@:%@", testKey, testValue]];
        
    });

});

SPEC_END


