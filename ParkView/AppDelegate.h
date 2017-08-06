//
//  AppDelegate.h
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class ParkAPIMgr;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) ParkAPIMgr *m_ParkAPIMgr;

- (void)saveContext;


@end

