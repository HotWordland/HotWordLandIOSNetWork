//
//  Utility.h
//  CloudTravel
//
//  Created by hetao on 10-12-5.
//  Copyright 2010 oulin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define showProgressIndicator_width 250

@interface Utility : NSObject
//badgeViewS
@property (nonatomic,retain) NSMutableDictionary *badgeViewDict;
@property (nonatomic,assign) BOOL offline;
//userid
@property (nonatomic,assign) int  userid;
//登陆状态
//@property (assign,nonatomic) BOOL online;
//会员账号
@property (nonatomic,strong) NSString  *userName;
@property (nonatomic,assign) int  timeReply;
@property (nonatomic,assign) int  timeBefor;
//选择自动登陆
@property (nonatomic,strong) NSString *State;
//存储用户信息plist
@property (nonatomic,strong)NSUserDefaults *nsuser;
//版本信息
@property (nonatomic,strong)NSString *Version;
@property(nonatomic,strong)NSString *ONLINE;

@property (nonatomic,strong)NSString *Administrutor_Linkman;
@property (nonatomic,strong)NSString *Administrutor_QQ;
@property (nonatomic,strong)NSString *Administrutor_PhoneNumber;
+(id)Share;
-(NSString *)getAddressBy:(NSString *)description;
- (NSString*)timeToNow:(NSString*)theDate needYear:(BOOL)needYear;
- (BOOL)isFocusSession:(NSString*)sid;
- (BOOL)isFocusSpeak:(NSString*)sid;
@end
