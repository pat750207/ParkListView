//
//  GLSplashView.h
//  GLSplashView
//
//  Created by seven on 16/3/29.
//  Copyright © 2016年 GOLiFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@class GLSplashIcon;
@class GLSplashView;

@protocol GLSplashDelegate <NSObject>
@optional
- (void) splashView: (GLSplashView *) splashView didBeginAnimatingWithDuration: (float) duration;
- (void) splashViewDidEndAnimating: (GLSplashView *) splashView;

@end

typedef NS_ENUM(NSInteger, GLSplashAnimationType)
{
    GLSplashAnimationTypeBounce,
};

@interface GLSplashView : UIView

@property (strong, nonatomic) UIColor *backgroundViewColor; //Default: white
@property (strong, nonatomic) UIImage *backgroundImage;
@property (nonatomic, assign) CGFloat animationDuration; //Default: 1s

@property (weak, nonatomic) id <GLSplashDelegate> delegate;

- (instancetype)initWithAnimationType: (GLSplashAnimationType) animationType;
- (instancetype)initWithBackgroundColor: (UIColor *) backgroundColor animationType: (GLSplashAnimationType) animationType;
- (instancetype)initWithBackgroundImage: (UIImage *) backgroundImage animationType: (GLSplashAnimationType) animationType;
- (instancetype)initWithSplashIcon: (GLSplashIcon *)icon animationType: (GLSplashAnimationType) animationType;
- (instancetype) initWithSplashIcon:(GLSplashIcon *)icon backgroundColor: (UIColor *) backgroundColor animationType:(GLSplashAnimationType) animationType;
- (instancetype) initWithSplashIcon:(GLSplashIcon *)icon backgroundImage:(UIImage *) backgroundImage animationType:(GLSplashAnimationType) animationType;

- (void) setCustomAnimationType: (CAAnimation *) animation;

- (void)startAnimation;
- (void)startAnimationWhileExecuting: (NSURLRequest *) request withCompletion:(void(^)(NSData *data, NSURLResponse *response, NSError *error)) completion; //NOTE: Splash View returns regardless of whether request was success -> error handling highly recommended

@end