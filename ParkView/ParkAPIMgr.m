//
//  ParkAPIMgr.m
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import "ParkAPIMgr.h"

#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "JSONKit.h"


@interface NSDictionary (BVJSONString)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end

@implementation NSDictionary (BVJSONString)

-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end

@implementation ParkAPIMgr

@synthesize parkRequest;
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.

    }
    
    return self;
}

- (void)getParkList
{
        
    [parkRequest cancel];
    [self setParkRequest:[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812"]]];
 
    
    [parkRequest setValidatesSecureCertificate:NO];
    [parkRequest setUseCookiePersistence:NO];
    //[parkRequest setRequestCookies:[NSMutableArray arrayWithObject:self.sessionCookie]];
    [parkRequest setTimeOutSeconds:60];
    [parkRequest setDelegate:self];
    [parkRequest setDidFailSelector:@selector(getParkListFailed:)];
    [parkRequest setDidFinishSelector:@selector(getParkListFinished:)];
    [parkRequest setRequestMethod:@"GET"];
    
    [parkRequest startAsynchronous];
    
}

- (void)getParkListFailed:(ASIHTTPRequest *)theRequest
{
    NSLog(@"Error Code %@",[[theRequest error] localizedDescription]);
    if (nil != delegate && [delegate respondsToSelector:@selector(getParkListResponse:userInfo:)]) {
        [self.delegate getParkListResponse:GET_PRAKE_RESULT_CONNECTION_ERROR parkInfo:nil];
    }
}

- (void)getParkListFinished:(ASIHTTPRequest *)theRequest
{
    NSInteger statusCode = [parkRequest responseStatusCode];
    NSString *receiveMessage = [parkRequest responseString];
    
    //NSLog(@"%@", receiveMessage);
    
    if (200 == statusCode)
    {
        JSONDecoder* decoder = [[JSONDecoder alloc] init];
        NSDictionary *resultsDictionary = [decoder objectWithData:[receiveMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        NSDictionary *resultDictionary = [resultsDictionary objectForKey:@"result"];
        NSArray *dataArray = [resultDictionary objectForKey:@"results"];
        /*
        for (NSDictionary *data in dataArray)
        {
            NSLog(@"*****************");
            NSLog(@"%@",[data objectForKey:@"ParkName"]);
            NSLog(@"%@",[data objectForKey:@"Name"]);
            NSLog(@"%@",[data objectForKey:@"OpenTime"]);
            NSLog(@"%@",[data objectForKey:@"Image"]);
            NSLog(@"%@",[data objectForKey:@"Introduction"]);
        }*/

        NSString *retMessage = [resultsDictionary objectForKey:@"message"];
        NSLog(@"retMessage : %@", retMessage);
        
        if (nil != delegate && [delegate respondsToSelector:@selector(getParkListResponse:parkInfo:)]) {
            [self.delegate getParkListResponse:GET_PRAK_RESULT_OK parkInfo:dataArray];
        }
    }
    else
    {
        NSLog(@"Error Code %@",[[theRequest error] localizedDescription]);
        
        if (nil != delegate && [delegate respondsToSelector:@selector(getParkListResponse:parkInfo:)])
        {
            if (500 == statusCode) {
                [self.delegate getParkListResponse:GET_PRAK_RESULT_SERVER_ERROR parkInfo:nil];
            }
            else if (400 == statusCode) {
                [self.delegate getParkListResponse:GET_PRAK_RESULT_BAD_REQUEST parkInfo:nil];
            }
            else if (404 == statusCode) {
                [self.delegate getParkListResponse:GET_PRAK_RESULT_NOT_FOUND parkInfo:nil];
            }
            else if (401 == statusCode) {
                [self.delegate getParkListResponse:GET_PRAK_RESULT_UNAUTHORIZED parkInfo:nil];
            }
            else {
                [self.delegate getParkListResponse:GET_PRAK_RESULT_NO_STATUS_CODE parkInfo:nil];
            }
        }
    }
}


@end
