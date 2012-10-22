#import "Kiwi.h"
#import "DXHTTPConnectionOperation.h"

SPEC_BEGIN(DXHTTPConnectionSpec)

describe(@"DXHTTPConnection", ^{
    it(@"Should start NSURLConnection in DXHTTPConnectionOperation", ^{
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost"]];
        DXHTTPConnectionOperation *connectionOperation = [[DXHTTPConnectionOperation alloc] initWithURLRequest:urlRequest];
        [connectionOperation start];   
    });
});

SPEC_END