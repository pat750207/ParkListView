//
//  AppDelegate.m
//  ParkView
//
//  Created by Pat Chang on 2017/8/3.
//  Copyright © 2017年 Pat Chang. All rights reserved.
//

#import "AppDelegate.h"
#import "GLSplashIcon.h"
#import "GLSplashView.h"
#import "ParkAPIMgr.h"
#import "ParkListViewController.h"


@interface AppDelegate ()<ParkAPIMgrDelegate>

@property (strong, nonatomic) GLSplashView *splashView;

@end

@implementation AppDelegate

@synthesize m_ParkAPIMgr;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    m_ParkAPIMgr = [[ParkAPIMgr alloc] init];
    m_ParkAPIMgr.delegate=self;
    [m_ParkAPIMgr getParkList];
   
    
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)getParkListResponse:(GET_PRAK_RESULT)result parkInfo:(NSArray*)parksArray;
{
    NSMutableArray* parkArray = [[NSMutableArray alloc] init] ;
    if (result == GET_PRAK_RESULT_OK)
    {
        parkArray = [parksArray copy];
        /*
        for (NSDictionary *data in parkArray)
        {
            NSLog(@"*****************");
            NSLog(@"%@",[data objectForKey:@"ParkName"]);
            NSLog(@"%@",[data objectForKey:@"Name"]);
            NSLog(@"%@",[data objectForKey:@"OpenTime"]);
            NSLog(@"%@",[data objectForKey:@"Image"]);
            NSLog(@"%@",[data objectForKey:@"Introduction"]);
        }*/
        
        UIStoryboard* keyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* rootVC = [keyBoard instantiateInitialViewController];
        self.window.rootViewController = rootVC;
        [self.window makeKeyAndVisible];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, USEC_PER_SEC), dispatch_get_main_queue(), ^{
            if([((UINavigationController*)self.window.rootViewController).viewControllers[0]  isKindOfClass:[ParkListViewController class]])
            {
                ParkListViewController* viewController = ((UINavigationController*)self.window.rootViewController).viewControllers[0];
                viewController.mParkList = [parkArray copy];
                [viewController.mParkListTable reloadData];
            }

        });
        
        
        
    }
    else
    {
        NSLog(@"Get ParkList Error");
       
    }
}

/*
- (void)startupSplash
{

    NSString *launchImg = @"logo";

    
    GLSplashIcon *twitterSplashIcon = [[GLSplashIcon alloc] initWithImage:[UIImage imageNamed:launchImg] animationType:GLIconAnimationTypeBounce];
    UIColor *twitterColor = [UIColor whiteColor];
    _splashView = [[GLSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:GLSplashAnimationTypeBounce];
    _splashView.animationDuration = 3;
    
    [self.window.rootViewController.view addSubview:_splashView];
    [_splashView startAnimation];
}*/


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ParkView"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
