//
//  CNetEngine.h
//  ScbClient
//
//  Created by xy z on 10-11-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CNetRequest;

@protocol MNetReqCallBack

-(void) netReqCallBack:(NSInteger)aCode responseData:(NSData*)aRsqData 
               reqType:(NSInteger)aReqType addition:(id)aAddition; 

@end

@interface CNetRequestInfo : NSObject
{
    NSInteger mReqType;
    CNetRequest* mNetRequest;
    id<MNetReqCallBack> mCallback;
    id mReqAddition;
}

@property (nonatomic, assign) NSInteger mReqType;
@property (nonatomic, retain) CNetRequest* mNetRequest;
@property (nonatomic, assign) id<MNetReqCallBack> mCallback;
@property (nonatomic, assign) id mReqAddition;

@end


@interface CNetEngine : NSObject 
{
    NSMutableArray* netRequestList;
    NSMutableArray* netImageList;
}

-(void) sendNetRequest:(NSString*)aReqUrl requestBody:(NSString*)aReqBody 
              obersver:(id<MNetReqCallBack>)aCallback reqType:(NSInteger)aReqType addition:(id)aReqAddition;

-(void)netDataReceived:(NSInteger)aCode responseData:(NSData*)aRsqData request:(CNetRequest*)aRequest;

-(void)cancelImageRequest;

@end
