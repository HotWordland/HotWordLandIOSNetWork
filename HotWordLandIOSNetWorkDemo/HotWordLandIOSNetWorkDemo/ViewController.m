//
//  ViewController.m
//  HotWordLandIOSNetWorkDemo
//
//  Created by Ronaldinho on 14/12/30.
//  Copyright (c) 2014年 HotWordLand. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view, typically from a nib.
        [ProgressHUD show:@"Ready" Interaction:NO];
//    [self performSelector:@selector(delayShow) withObject:nil afterDelay:3.0f];
    /**
    [NetEngine createHttpAction:getUserInfoUrl() withParams:@{@"username":@"123533"} onCompletion:^(id resData, BOOL isCache) {
        if (resData!=nil) {
            DLog(@"%@",resData);
        }
    } onError:^(NSError *error) {
        
    } useCache:NO withMask:@"Ready"];
    */
}
-(void)delayShow
{
    [ProgressHUD show:@"Ready?"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
