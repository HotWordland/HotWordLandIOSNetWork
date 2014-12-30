//
//  viewCategory.h
//  cloud
//
//  Created by jack ray on 11-4-16.
//  Copyright 2011年 oulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Addition)<UITextFieldDelegate>

-(void)addImageBg;
-(void)addImageBgWithoutResize;
-(void)addImageBgWith:(UIImage *)__image;
//-(void)addimageClick;
-(void)roundCorner;
-(void)rotateViewStart;
-(void)rotateViewStop;
-(void)addSubviews:(UIView *)view,...;

-(void)imagesWithURL:(NSString *)url useProgress:(BOOL)useProgress usActivity:(BOOL) useActivity;
@end
