//
//  CNetEngine.m
//  ScbClient
//
//  Created by xy z on 10-11-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CNetEngine.h"
#import "CNetRequest.h"

#define kGetImageType 0

@implementation CNetRequestInfo

@synthesize mReqType;
@synthesize mNetRequest;
@synthesize mCallback;
@synthesize mReqAddition;

-(void)dealloc
{
    [mNetRequest release]; 
    [super dealloc];
}

@end


@implementation CNetEngine

-(id)init
{
    if (self = [super init])
    {
        netRequestList = [[NSMutableArray alloc] init];
        netImageList = [[NSMutableArray alloc] init];;
    }
    return self;
}

-(void) sendNetRequest:(NSString*)aReqUrl requestBody:(NSString*)aReqBody 
              obersver:(id<MNetReqCallBack>)aCallback reqType:(NSInteger)aReqType addition:(id)aReqAddition
{
    CNetRequest* netRequest = [[CNetRequest alloc] initWithManager:self];
    if ([netRequest sendNetRequest:aReqUrl requestBody:aReqBody])
    {
        if (nil != aCallback)
        {
            CNetRequestInfo* reqInfo = [[CNetRequestInfo alloc] init];
            reqInfo.mReqType = aReqType;
            reqInfo.mNetRequest = netRequest;
            reqInfo.mCallback = aCallback;
            reqInfo.mReqAddition = aReqAddition;
            
            if (aReqType == kGetImageType)
            {
                [netImageList addObject:reqInfo];
            }
            else 
            {
                [netRequestList addObject:reqInfo];
            }
            [reqInfo release];
        }
    }
    [netRequest release];
}

-(void)netDataReceived:(NSInteger)aCode responseData:(NSData*)aRsqData request:(CNetRequest*)aRequest
{
    CNetRequestInfo* info = nil;
    for (info in netRequestList)
    {
         if (info.mNetRequest == aRequest)
         {
             [info retain];
             [netRequestList removeObject:info];
             break;
         }
        info = nil;
    }
    if (nil == info)
    {
        for (info in netImageList)
        {
            if (info.mNetRequest == aRequest)
            {
                [info retain];
                [netImageList removeObject:info];
                break;
            }
            info = nil;
        }
    }
    
    if (nil == info)
    {
        return;
    }
    
    if (0 == aCode)
    {
        [info.mCallback netReqCallBack:0 responseData:aRsqData reqType:info.mReqType addition:info.mReqAddition];
    }
    else 
    {
        [info.mCallback netReqCallBack:aCode responseData:nil reqType:info.mReqType addition:nil];
    }
    [info release];
}

-(void)cancelImageRequest
{
    [netImageList removeAllObjects];
}

-(void)dealloc
{
    [netImageList release];
    [netRequestList release]; 
    [super dealloc];
}

@end
