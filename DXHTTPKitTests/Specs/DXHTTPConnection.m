#import "Kiwi.h"
#import "DXHTTPConnectionOperation.h"

SPEC_BEGIN(DXHTTPConnectionSpec)

describe(@"DXHTTPConnection", ^{
    
    __block DXHTTPConnectionOperation *connectionOperation;
    __block NSURLRequest *urlRequest;
    
    beforeEach(^{
        urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost"]];
        connectionOperation = [[DXHTTPConnectionOperation alloc] initWithURLRequest:urlRequest];
        [connectionOperation start];
    });
    
    context(@"Right values", ^{
        
        it(@"DXHTTPConnection should be executing", ^{
            [[theValue([connectionOperation isExecuting]) should] beTrue];
        });
        
        it(@"Should set connectionData in DXHTTPConnectionOperation", ^{
            NSData *dataForTesting = [[NSString stringWithFormat:@"Data for Testing"] dataUsingEncoding:NSUTF8StringEncoding];
            [connectionOperation connection:[connectionOperation urlConnection] didReceiveData:dataForTesting];
            
            [[[connectionOperation connectionData] should] equal:dataForTesting];
        });
        
        it(@"Data in connectionOperation should be zero in time of resiveResponce", ^{
            [connectionOperation connection:[connectionOperation urlConnection] didReceiveResponse:nil];
            [[theValue([[connectionOperation connectionData] length]) should] equal:theValue(0)];
        });
        
        it(@"DXConnectionOperation shoul be concurrent", ^{
            [[theValue([connectionOperation isConcurrent]) should] beTrue];
        });
    });
});

SPEC_END