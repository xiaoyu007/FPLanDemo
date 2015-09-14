//
//  CNetEngine.h
//  CMRead
//
//  Created by vanceinfo on 10-8-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CNetEngine;

@interface CNetRequest : NSObject
{
    NSMutableData* mReceiveData;
    NSMutableDictionary* mHeadFields;
    CNetEngine* mNetManager;
    NSURLConnection* mTheConnection;
    NSInteger statusCode;
}

@property (nonatomic, retain) NSMutableData* mReceiveData;
@property (nonatomic, retain) NSMutableDictionary* mHeadFields;
@property (nonatomic, assign) CNetEngine* mNetManager;

-(id) initWithManager:(CNetEngine*)aManager;

-(BOOL) sendNetRequest:(NSString*)aReqUrl requestBody:(NSString*)aReqBody;

@end
