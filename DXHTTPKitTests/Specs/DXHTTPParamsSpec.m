//
//  DXHTTPParamsSpec.m
//  DXHTTPKit
//
//  Created by Sergey Zenchenko on 10/15/12.
//  Copyright 2012 111Minutes. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "DXHTTPParam.h"
#import "DXHTTPFormParam.h"
#import "DXHTTPFormFileDescriptor.h"

SPEC_BEGIN(DXHTTPParamsSpec)

NSString *testKey = @"testKey";

describe(@"Basic key param", ^{
    it(@"Should keep key value", ^{
        
        DXHTTPParam *keyParam = [[DXHTTPParam alloc] initWithKey:testKey];
        
        [[keyParam.key should] equal:testKey];
    });
    
    it(@"Should throw exception in case of non string key type", ^{
       [[theBlock(^{
           DXHTTPParam *keyParams __attribute__((unused)) = [[DXHTTPParam alloc] initWithKey:(NSString*)@[]];
       }) should] raiseWithName:NSInternalInconsistencyException];
    });
    
    it(@"Should throw exception in case of non nil key", ^{
        [[theBlock(^{
            DXHTTPParam *keyParams __attribute__((unused)) = [[DXHTTPParam alloc] initWithKey:nil];
        }) should] raiseWithName:NSInternalInconsistencyException];
        
    });
});

describe(@"Form params", ^{
    NSString *testValue = @"testValue";
    it(@"Should keep form key and value", ^{
        DXHTTPFormParam *param = [[DXHTTPFormParam alloc] initWithKey:testKey value:testValue];
        
        [[param.key should] equal:testKey];
        [[param.value should] equal:testValue];
    });
    
    it(@"Should throw exception in case of non string value type", ^{
        [[theBlock(^{
            DXHTTPFormParam *keyParams __attribute__((unused)) = [[DXHTTPFormParam alloc] initWithKey:testKey value:@[]];
        }) should] raiseWithName:NSInternalInconsistencyException];
    });
    
    it(@"Should accept nil values", ^{
        [[theBlock(^{
            DXHTTPFormParam *keyParams __attribute__((unused)) = [[DXHTTPFormParam alloc] initWithKey:testKey value:nil];
        }) shouldNot] raise];
    });
    
    context(@"File params", ^{
        it(@"Should accept file params", ^{
            DXHTTPFormFileDescriptor *fd = [DXHTTPFormFileDescriptor new];
            [[theBlock(^{
                DXHTTPFormParam *keyParams __attribute__((unused)) = [[DXHTTPFormParam alloc] initWithKey:testKey value:fd];
            }) shouldNot] raise];
        });
    });
});


SPEC_END


