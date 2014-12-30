//
//  RHMethods.m
//  ktvdr
//
//  Created by 何涛 Thomas on 12-4-8.
//  Copyright (c) 2012年 重庆奥芬多网络科技有限公司. All rights reserved.
//

#import "RHMethods.h"
@implementation RHMethods
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext;
{
    UILabel *baseLabel=[[UILabel alloc] initWithFrame:aframe];
    if(afont)baseLabel.font=afont;
    if(acolor)baseLabel.textColor=acolor;
    if (aframe.size.height>20) {
        baseLabel.numberOfLines=0;
    }
    baseLabel.lineBreakMode=UILineBreakModeCharacterWrap;
    baseLabel.text=atext;
    
    baseLabel.backgroundColor=[UIColor clearColor];
    baseLabel.highlightedTextColor=[UIColor whiteColor];
    return [baseLabel autorelease];
}

+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title image:(NSString*)_image bgimage:(NSString*)_bgimage
{
    UIButton *baseButton=[[UIButton alloc] initWithFrame:_frame];
    if (_title) {
        [baseButton setTitle:_title forState:UIControlStateNormal];
        [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (_image) {
        [baseButton setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
    }
    if (_bgimage) {
        [baseButton setBackgroundImage:[UIImage imageNamed:_bgimage] forState:UIControlStateNormal];
    }
    
    return [baseButton autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image
{
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:_frame];
    if(_image){
        imageview.image=[UIImage imageNamed:_image];  
    }
    
    return [imageview autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame image:(NSString*)_name stretchW:(NSInteger)_w stretchH:(NSInteger)_h
{
    UIImageView *cellBg =nil;
    if (_w==0&&_h==0) {
        cellBg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:_name]];
    }else{
            cellBg=[[UIImageView alloc] initWithImage:
                    [[UIImage imageNamed:_name] stretchableImageWithLeftCapWidth:_w topCapHeight:_h]];

    }
    if (!CGRectIsNull(_frame)) {
        [cellBg setFrame:_frame];
    }
    return  [cellBg autorelease]; 
}

@end