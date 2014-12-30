//
//  RHMethods.h
//  ktvdr
//
//  Created by 何涛 Thomas on 12-4-8.
//  Copyright (c) 2012年 重庆奥芬多网络科技有限公司. All rights reserved.
//

#define W(obj)   (!obj?0:(obj).frame.size.width)
#define H(obj)   (!obj?0:(obj).frame.size.height)
#define X(obj)   (!obj?0:(obj).frame.origin.x)
#define Y(obj)   (!obj?0:(obj).frame.origin.y)
#define XW(obj) X(obj)+W(obj)
#define YH(obj) Y(obj)+H(obj)
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]
#define Font(x) [UIFont systemFontOfSize:x]

#define CGRectMakeXY(x,y,size) CGRectMake(x,y,size.width,size.height)



#import <Foundation/Foundation.h>
#import "viewCategory.h" //addsubviews
@interface RHMethods : NSObject

+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext;
+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame image:(NSString*)_name stretchW:(NSInteger)_w stretchH:(NSInteger)_h;
@end
