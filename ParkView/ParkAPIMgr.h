//
//  ParkAPIMgr
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@class ASIFormDataRequest;
@class ASIHTTPRequest;
@class Reachability;
@class ASINetworkQueue;

typedef enum
{
    GET_PRAK_RESULT_NO_STATUS_CODE = 0,
    GET_PRAK_RESULT_OK = 200,
    GET_PRAK_RESULT_BAD_REQUEST = 400,
    GET_PRAK_RESULT_UNAUTHORIZED = 401,
    GET_PRAK_RESULT_FORBIDDEN = 403,
    GET_PRAK_RESULT_NOT_FOUND = 404,
    GET_PRAK_RESULT_CONFLICT = 409,
    GET_PRAK_RESULT_SERVER_ERROR = 500,
    GET_PRAKE_RESULT_CONNECTION_ERROR = 520,
    GET_PRAK_RESULT_NETWORK_NOT_ENABLE = 601
} GET_PRAK_RESULT;

@protocol ParkAPIMgrDelegate <NSObject>
@optional
- (void)getParkListResponse:(GET_PRAK_RESULT)result parkInfo:(NSArray*)profileArray;
@end

@interface ParkAPIMgr : NSObject
{
    ASIFormDataRequest *parkRequest;
}

@property (strong, nonatomic) NSHTTPCookie *sessionCookie;
@property (strong, nonatomic) ASIFormDataRequest *parkRequest;
@property (strong, nonatomic) ASIFormDataRequest *parkRequestForCARE;
@property (nonatomic,weak) id<ParkAPIMgrDelegate> delegate;


- (void)getParkList;

@end


