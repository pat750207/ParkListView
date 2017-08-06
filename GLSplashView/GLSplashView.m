//
//  GLSplashView.m
//  GLSplashView
//
//  Created by seven on 16/3/29.
//  Copyright © 2016年 GOLiFE. All rights reserved.
//

#import "GLSplashView.h"
#import "GLSplashIcon.h"

@interface GLSplashView() <NSURLConnectionDataDelegate>

@property (nonatomic, assign) GLSplashAnimationType animationType;
@property (nonatomic, assign) GLSplashIcon *splashIcon;
@property (strong, nonatomic) CAAnimation *customAnimation;

@end

@implementation GLSplashView

#pragma mark - Instance methods

- (instancetype)initWithAnimationType:(GLSplashAnimationType)animationType
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self)
    {
        _animationType = animationType;
    }
    
    return self;
}

- (instancetype) initWithBackgroundColor:(UIColor *)backgroundColor animationType:(GLSplashAnimationType)animationType
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self)
    {
        _backgroundViewColor = backgroundColor;
        self.backgroundColor = [self setBackgroundViewColor];
        _animationType = animationType;
    }
    
    return self;
}

- (instancetype) initWithBackgroundImage:(UIImage *)backgroundImage animationType:(GLSplashAnimationType)animationType
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self)
    {
        _backgroundImage = backgroundImage;
        _animationType = animationType;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
    }
    
    return self;
}

- (instancetype) initWithSplashIcon:(GLSplashIcon *)icon animationType:(GLSplashAnimationType)animationType
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self)
    {
        _splashIcon = icon;
        _animationType = animationType;
        self.backgroundColor = [self setBackgroundViewColor];
        icon.center = self.center;
        [self addSubview:icon];
    }
    
    return self;
}

- (instancetype) initWithSplashIcon:(GLSplashIcon *)icon backgroundColor:(UIColor *)backgroundColor animationType:(GLSplashAnimationType)animationType
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self)
    {
        _splashIcon = icon;
        _backgroundViewColor = backgroundColor;
        _animationType = animationType;
        icon.center = self.center;
        self.backgroundColor = _backgroundViewColor;
        [self addSubview:icon];
    }
    return self;
}

- (instancetype) initWithSplashIcon:(GLSplashIcon *)icon backgroundImage:(UIImage *)backgroundImage animationType:(GLSplashAnimationType)animationType
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self)
    {
        _splashIcon = icon;
        _backgroundImage = backgroundImage;
        _animationType = animationType;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        [self addSubview:icon];
        icon.center = imageView.center;
    }
    return self;
}

#pragma mark - Public methods

- (void)startAnimation;
{
    if(_splashIcon) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%f",self.animationDuration] forKey:@"animationDuration"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startAnimation" object:self userInfo:dic];
    }
    if([self.delegate respondsToSelector:@selector(splashView:didBeginAnimatingWithDuration:)])
    {
        [self.delegate splashView:self didBeginAnimatingWithDuration:self.animationDuration];
    }
    
    
    [self addBounceAnimation];
 
}

- (void) startAnimationWhileExecuting:(NSURLRequest *)request withCompletion:(void (^)(NSData *, NSURLResponse *, NSError *))completion
{
    if(_splashIcon) { //trigger splash icon animation
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startAnimation" object:self userInfo:nil];
    }
    
    if([self.delegate respondsToSelector:@selector(splashView:didBeginAnimatingWithDuration:)])
    {
        [self.delegate splashView:self didBeginAnimatingWithDuration:self.animationDuration];
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"stopAnimation" object:self userInfo:nil]; //remove animation on data retrieval
         [self removeSplashView];
         completion(data, response, error);
     }];
}

- (void) setCustomAnimationType:(CAAnimation *)animation
{
    _customAnimation = animation;
}

- (void) setBackgroundImage:(UIImage *)backgroundImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:imageView];
}

#pragma mark - Property setters

- (CGFloat)animationDuration
{
    if (!_animationDuration) {
        _animationDuration = 1.0f;
    }
    return _animationDuration;
}

- (CAAnimation *)customAnimation
{
    if (!_animationType) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@1, @0.9, @300];
        animation.keyTimes = @[@0, @0.4, @1];
        animation.duration = self.animationDuration;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        _customAnimation = animation;
    }
    return _customAnimation;
}

- (UIColor *) setBackgroundViewColor
{
    if (!_backgroundViewColor) {
        _backgroundViewColor = [UIColor whiteColor];
    }
    return _backgroundViewColor;
}

#pragma mark - Animations

- (void) addBounceAnimation
{
    CGFloat bounceDuration = self.animationDuration * 0.8;
    [NSTimer scheduledTimerWithTimeInterval:bounceDuration target:self selector:@selector(pingGrowAnimation) userInfo:nil repeats:NO];
}

- (void) pingGrowAnimation
{
    CGFloat growDuration = self.animationDuration *0.2;
    [UIView animateWithDuration:growDuration animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
        self.transform = scaleTransform;
        self.alpha = 0;
        self.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        [self removeSplashView];
    }];
}

- (void) addNoAnimation
{
    [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(removeSplashView) userInfo:nil repeats:NO];
}

- (void) addCustomAnimationWithAnimation: (CAAnimation *) animation
{
    [self.layer addAnimation:animation forKey:@"GLSplashAnimation"];
    [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(removeSplashView) userInfo:nil repeats:YES];
}

- (void) removeSplashView
{
    [self removeFromSuperview];
    [self endAnimating];
}

- (void) endAnimating
{
    if([self.delegate respondsToSelector:@selector(splashViewDidEndAnimating:)])
    {
        [self.delegate splashViewDidEndAnimating:self];
    }
}

@end
