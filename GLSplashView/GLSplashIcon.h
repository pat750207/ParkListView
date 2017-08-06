//
//  GLSplashIcon.h
//  GLSplashView
//
//  Created by seven on 16/3/29.
//  Copyright © 2016年 GOLiFE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLSplashView.h"

typedef NS_ENUM(NSInteger, GLIconAnimationType)
{
    GLIconAnimationTypeBounce,
};

@interface GLSplashIcon : UIImageView

@property (strong, nonatomic) UIColor *iconColor;
@property (nonatomic, assign) CGSize iconSize; //Default: 213x41
@property (strong, nonatomic) GLSplashView *splashView;

- (instancetype) initWithImage: (UIImage *) iconImage;

- (instancetype) initWithImage: (UIImage *) iconImage animationType: (GLIconAnimationType) animationType;

- (void) setIconAnimationType: (GLIconAnimationType) animationType;
- (void) setCustomAnimation: (CAAnimation *) animation;

@end
