//
//  CNetEngine.m
//  CMRead
//
//  Created by vanceinfo on 10-8-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CNetRequest.h"
#import "CNetEngine.h"





@implementation CNetRequest

@synthesize mReceiveData;
@synthesize mHeadFields;
@synthesize mNetManager;

-(id) initWithManager:(CNetEngine*)aManager
{
    if (self = [super init])
    {
        mHeadFields = [[NSMutableDictionary alloc] init];
        mNetManager = aManager;
    }
    return self;
}

-(BOOL) sendNetRequest:(NSString*)aReqUrl requestBody:(NSString*)aReqBody 
{
    NSURL* url = [[NSURL alloc] initWithString:aReqUrl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [url release];
    
    if (nil != aReqBody)
    {
        [request setHTTPMethod:@"POST"];
        NSData* httpBody = [aReqBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:httpBody];
    }
    
    mTheConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request release];
    if (nil != mTheConnection)
    {
        NSMutableData* data = [[NSMutableData alloc] init];
        self.mReceiveData = data;
        [data release];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void) dealloc
{
    [mTheConnection cancel];
    [mTheConnection release];
    [mReceiveData release];
    [mHeadFields release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSURLConnection Callbacks
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [mReceiveData setLength:0];
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        statusCode = [httpResponse statusCode];
    }
    else
    {
        statusCode = 200;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mReceiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [connection release];
    mTheConnection = nil;
    if (statusCode >= 200 && statusCode < 300)
    {
        [mNetManager netDataReceived:0 responseData:mReceiveData request:self];
    }
    else
    {
        [mNetManager netDataReceived:statusCode responseData:mReceiveData request:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
    mTheConnection = nil;
    self.mReceiveData = nil;
    
    [mNetManager netDataReceived:[error code] responseData:nil request:self];
}

@end
