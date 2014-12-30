//
//  viewCategory.m
//  cloud
//
//  Created by jack ray on 11-4-16.
//  Copyright 2011年 oulin. All rights reserved.
//

#import "viewCategory.h"
#import <QuartzCore/QuartzCore.h>
#import "NetEngine.h"
#define showProgressIndicator_width 250
@implementation UIView(Addition)

-(void)addImageBg
{
    UIView *superView = [self superview];
    if (superView) {
        CGRect originRect = self.frame;
        if (self.frame.origin.x != 2 && self.frame.origin.y != 2) {
            [self setFrame:CGRectMake(2, 2, originRect.size.width, originRect.size.height)];
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(originRect.origin.x - 2,
                                                                      originRect.origin.y - 2,
                                                                      originRect.size.width + 4,
                                                                      originRect.size.height + 4)];
            UIImageView *imageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                     0,
                                                                                     bgView.frame.size.width,
                                                                                     bgView.frame.size.height)];
            imageBgView.tag = 999;
            
            [imageBgView setImage:[[UIImage imageNamed:@"head_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
            
            [bgView addSubview:imageBgView];[imageBgView release];
            [bgView addSubview:self];
            [superView addSubview:bgView];[bgView release];
        }
        else if([superView viewWithTag:999])
        {
            [superView setFrame:CGRectMake(superView.frame.origin.x + self.frame.origin.x,
                                           superView.frame.origin.y,
                                           originRect.size.width + 4,
                                           originRect.size.height + 4)];
            UIImageView *imageBgView = (UIImageView *)[superView viewWithTag:999];
            [imageBgView setFrame:CGRectMake(0,
                                             0,
                                             superView.frame.size.width,
                                             superView.frame.size.height)];
            
            [self setFrame:CGRectMake(2, 2, self.frame.size.width, self.frame.size.height)];
        }
    }
}

-(void)addImageBgWithoutResize
{
    UIView *superView = [self superview];
    if (superView) {
        CGRect originRect = self.frame;
        if (self.frame.origin.x != 2 && self.frame.origin.y != 2) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(originRect.origin.x - 2,
                                                                      originRect.origin.y - 2,
                                                                      originRect.size.width + 4,
                                                                      originRect.size.height + 4)];
            UIImageView *imageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                     0,
                                                                                     bgView.frame.size.width,
                                                                                     bgView.frame.size.height)];
            imageBgView.tag = 990;
            [self setFrame:CGRectMake(2, 2, originRect.size.width, originRect.size.height)];
            [imageBgView setImage:[[UIImage imageNamed:@"head_bg.png"] stretchableImageWithLeftCapWidth:30 topCapHeight:30]];
            
            [bgView addSubview:imageBgView];[imageBgView release];
            [bgView addSubview:self];
            [superView addSubview:bgView];[bgView release];
        }
    }
}

-(void)addImageBgWith:(UIImage *)__image
{
    UIView *superView = [self superview];
    if (superView) {
        CGRect originRect = self.frame;
        UIImageView *imageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(originRect.origin.x - 3,
                                                                                 originRect.origin.y - 3,
                                                                                 originRect.size.width + 6,
                                                                                 originRect.size.height + 6)];
        [imageBgView setImage:[__image stretchableImageWithLeftCapWidth:30 topCapHeight:30]];

        [superView addSubview:imageBgView];[imageBgView release];
        [superView addSubview:self];
    }
}
//-(void)addimageClick
//{
//    if ([self isKindOfClass:[UIImageView class]] || [self isKindOfClass:[UIButton class]]) {
//        UIControl *control=[[UIControl alloc] initWithFrame:self.frame];
//        [control addTarget:self action:@selector(showCurrentImage:) forControlEvents:UIControlEventTouchUpInside];
//        [[self superview] addSubview:control];
//        [control release];
//    }        
//}
-(void)roundCorner
{
    self.layer.masksToBounds = YES;  
    self.layer.cornerRadius = 3.0;  
    self.layer.borderWidth = 1.0;
}

-(void)rotateViewStart;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * 5 * 2 ];
    rotationAnimation.duration = 5;
    //rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0; 
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
-(void)rotateViewStop
{
    //CFTimeInterval pausedTime=[self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    self.layer.speed=0.0;
//    self.layer.timeOffset=pausedTime;
    //self.layer.timeOffset = 0.0;  
    //self.layer.beginTime = 0.0; 
//    CFTimeInterval timeSincePause =4+ (pausedTime - (int)pausedTime);
//    NSLog(@".....%f",timeSincePause);
//    self.layer.timeOffset=timeSincePause;
//    self.layer.beginTime = 0.0;
//    [NSTimer timerWithTimeInterval:timeSincePause target:self selector:@selector(removeAnimation:) userInfo:nil repeats:NO];
    [self.layer removeAllAnimations];
}
- (void)removeAnimation:(id)obj
{
    [self.layer removeAllAnimations];
}
-(void)addSubviews:(UIView *)view,...
{
    [self addSubview:view];
    va_list ap;
    va_start(ap, view);
    UIView *akey=va_arg(ap,id);
    while (akey) {
        [self addSubview:akey];
        akey=va_arg(ap,id);
    }
    va_end(ap);
}

-(void)imagesWithURL:(NSString *)url  useProgress:(BOOL)useProgress usActivity:(BOOL) useActivity
{
    if (!url) {
        return;
    }
    if (self.frame.size.width > showProgressIndicator_width) {
        [self imageWithURL:url useProgress:useProgress usActivity:useActivity];
    }
    else
    {
        [self imageWithURL:url useProgress:useProgress usActivity:useActivity];
    }
}

-(void)imageWithURL:(NSString *)url useProgress:(BOOL)useProgress usActivity:(BOOL) useActivity
{
    UIView *tempView = nil;
    UIImageView *imgView = [self isKindOfClass:[UIImageView class]]?(UIImageView *)self:((UIButton *)self).imageView;
    
    [self isKindOfClass:[UIImageView class]] ? imgView.image = [UIImage imageNamed:@"main_eg.png"]:[((UIButton *)self) setBackgroundImage:[UIImage imageNamed:@"main_eg.png"] forState:UIControlStateNormal];
    
    if (useProgress) {
        CGFloat width = self.frame.size.width *0.8;
        CGFloat fX = (self.frame.size.width - width)/2.0;
        CGFloat fY = self.frame.size.height/2.0 - 10;
        UIProgressView *progressIndicator = [[UIProgressView alloc] initWithFrame:CGRectMake(fX, fY, width, 20)];
        [progressIndicator setProgressViewStyle:UIProgressViewStyleBar];
        if ([progressIndicator respondsToSelector:@selector(setProgressTintColor:)]) {
            [progressIndicator setProgressTintColor:[UIColor grayColor]];
        }
        tempView = progressIndicator;
    }
    else if(useActivity)
    {
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicatorView setCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0)];
        [activityIndicatorView startAnimating];
        tempView = activityIndicatorView;
    }
    tempView.userInteractionEnabled = NO;
    [self addSubview:tempView];
    
    MKNetworkOperation *op = [NetEngine imageAtURL:url onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        //下载之后可以压缩显示
        if([self isKindOfClass:[UIImageView class]]){
            imgView.image = fetchedImage;
        }else{
            [((UIButton *)self) setBackgroundImage:fetchedImage forState:UIControlStateNormal];
        }
        [tempView removeFromSuperview];
    }];
    
    if (useProgress) {
        UIProgressView *progressIndicator = (UIProgressView *)tempView;
        [op onDownloadProgressChanged:^(double progress) {
            [progressIndicator setProgress:progress];
        }];
    }
}
@end
