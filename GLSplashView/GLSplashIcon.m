//
//  GLSplashIcon.m
//  GLSplashView
//
//  Created by seven on 16/3/29.
//  Copyright © 2016年 GOLiFE. All rights reserved.
//

#import "GLSplashIcon.h"

@interface GLSplashIcon()

@property (nonatomic, assign) GLIconAnimationType animationType;
@property (strong, nonatomic) CAAnimation *customAnimation;
@property (nonatomic) BOOL indefiniteAnimation;
@property (strong, nonatomic) UIImage *iconImage;

@end

@implementation GLSplashIcon

#pragma mark - Initialization

- (instancetype) initWithImage:(UIImage *)iconImage
{
    self = [super init];
    if(self)
    {
        self.image = iconImage;
        self.tintColor = [self setIconStartColor];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.frame = CGRectMake(0, 0, iconImage.size.width, iconImage.size.height);
        [self addObserverForAnimationNotification];
    }
    
    return self;
}

- (instancetype) initWithImage:(UIImage *)iconImage animationType:(GLIconAnimationType)animationType
{
    self = [super init];
    if(self)
    {
        _animationType = animationType;
        _iconImage = iconImage;
        self.image = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.image = iconImage;
        self.tintColor = [self setIconStartColor];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.frame = CGRectMake(0, 0, iconImage.size.width, iconImage.size.height);
        [self addObserverForAnimationNotification];
    }
    
    return self;
}

#pragma mark - Public methods

- (void) setIconAnimationType:(GLIconAnimationType)animationType
{
    _animationType = animationType;
}

- (void) setCustomAnimation:(CAAnimation *)animation
{
    _customAnimation = animation;
}

#pragma mark - Property setters

- (CGSize)setIconStartSize
{
    if (!_iconSize.height) {
        _iconSize = CGSizeMake(213, 41);
    }
    return _iconSize;
}

- (UIColor *)setIconStartColor
{
    if (!_iconColor) {
        _iconColor = [UIColor whiteColor];
    }
    return _iconColor;
}

#pragma mark - Implementation

- (void) addObserverForAnimationNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"startAnimation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"stopAnimation" object:nil];
}

- (void) receiveNotification: (NSNotification *) notification
{
    if([notification.name isEqualToString:@"startAnimation"])
    {
        if(notification.userInfo [@"animationDuration"]){
            double duration = [notification.userInfo [@"animationDuration"] doubleValue];
            self.animationDuration = duration;
            [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(removeAnimations) userInfo:nil repeats:YES];
        }
        else {
            self.indefiniteAnimation = YES;
        }
        [self startAnimation];
    }
    else if([notification.name isEqualToString:@"stopAnimation"]) {
        [self removeAnimations];
    }
}

- (void) startAnimation
{
    [self addBounceAnimation];
}

- (void) addBounceAnimation
{
    CGFloat shrinkDuration = 0;
    CGFloat growDuration = self.animationDuration;
    
    [UIView animateWithDuration:shrinkDuration delay:0 usingSpringWithDamping:1.f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, 1);
        self.transform = scaleTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:growDuration animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(2, 2);
            self.transform = scaleTransform;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

- (void) removeAnimations
{
    [self.layer removeAllAnimations];
    self.indefiniteAnimation = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}

- (void) addNoAnimation
{
    [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(removeAnimations) userInfo:nil repeats:YES];
}

- (void) addCustomAnimation: (CAAnimation *) animation
{
    [self.layer addAnimation:animation forKey:@"GLSplashAnimation"];
    [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(removeAnimations) userInfo:nil repeats:YES];
}

@end
