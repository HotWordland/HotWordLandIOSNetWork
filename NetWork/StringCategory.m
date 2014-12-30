//
//  StringRef.m
//  beta1
//
//  Created by jack ray on 11-1-17.
//  Copyright 2011 重庆奥芬多网络科技有限公司. All rights reserved.
//

#import "StringCategory.h"
#import "Utility.h"
@implementation NSString(StringCategory)

-(NSString*)replaceControlString
{
	self=[self stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
	self=[self stringByReplacingOccurrencesOfString:@"\b" withString:@"\\b"];
	self=[self stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
	self=[self stringByReplacingOccurrencesOfString:@"\r" withString:@"\\t"];
	self=[self stringByReplacingOccurrencesOfString:@"\t" withString:@"\\r"];
	self=[self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
	self=[self stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
	
	return self;
}
-(NSString*)replaceStoreKey
{
    NSRange range=[self rangeOfString:@"user.lat="];
    if (range.length==0) {
        range=[self rangeOfString:@"loc.latOffset="];
        if (range.length==0) {
            range=[self rangeOfString:@"lat="];
            if (range.length!=0) {
                NSInteger l=[[self substringFromIndex:[self rangeOfString:@"lng="].location] rangeOfString:@"&"].location;
                range.length=[self rangeOfString:@"lng="].location-range.location+l;
                self=[self stringByReplacingCharactersInRange:range withString:@""];
            }
        }else{
            NSInteger l=[[self substringFromIndex:[self rangeOfString:@"loc.lngOffset="].location] rangeOfString:@"&"].location;
            range.length=[self rangeOfString:@"loc.lngOffset="].location-range.location+l;
            self=[self stringByReplacingCharactersInRange:range withString:@""];
        }
    }else{
        NSInteger l=[[self substringFromIndex:[self rangeOfString:@"user.lng="].location] rangeOfString:@"&"].location;
        range.length=[self rangeOfString:@"user.lng="].location-range.location+l;
        self=[self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

//"upload/".length=7
-(NSString*)imagePathType:(imageType)__type
{
    if ((__type != imageSmallType && __type != imageBigType)) {
        return self;
    }else{
        return [self stringByReplacingOccurrencesOfString:@"/" withString:__type==imageSmallType?@"/s":@"/b" options:0 range:NSMakeRange(7, [self length]-7)];
    }
}
- (CGFloat)getHeightByWidth:(NSInteger)_width font:(UIFont *)_font
{
    //!self不会调用，不用判断了
    return [self sizeWithFont:_font constrainedToSize:CGSizeMake(_width, 1000) lineBreakMode:UILineBreakModeCharacterWrap].height;
}

//- (NSString *)indentString:(NSString*)_string font:(UIFont *)_font
//{
//    if (!_string) {
//        return self;
//    }else{
//        CGSize  size=[_string sizeWithFont:_font];
//        NSLog(@"%f,%f",size.width/[@" " sizeWithFont:_font].width,[@" " sizeWithFont:_font].width);
//        return [NSString stringWithFormat:@"%@%@",[@"" stringByPaddingToLength:(size.width/[@"_" sizeWithFont:_font].width+2)*2 withString:@" " startingAtIndex:0],self];
//    }
//}
- (NSString *)indentLength:(CGFloat)_len font:(UIFont *)_font
{
    NSString *str=@"";
    CGFloat temp=0.0;
    while (temp<=_len) {
        str=[str stringByAppendingString:@" "];
        temp=[str sizeWithFont:_font].width;
    }
    return [NSString stringWithFormat:@"%@%@",str,self];
    //[@"" stringByPaddingToLength:(_len/[@"_" sizeWithFont:_font].width+1) withString:@"_" startingAtIndex:0]
}
- (BOOL)notEmptyOrNull
{
    if ([self isEqualToString:@""]||[self isEqualToString:@"null"] || [self isEqualToString:@"\"\""] || [self isEqualToString:@"''"]) {
        return NO;
    }
    return YES;
}

+ (NSString *)replaceEmptyOrNull:(NSString *)checkString
{
    if (!checkString || [checkString isEqualToString:@""]||[checkString isEqualToString:@"null"]) {
        return @"";
    }
    return checkString;
}
-(NSString*)replaceTime
{
    self=[self stringByReplacingOccurrencesOfString:@"-" withString:@"年" options:0 range:NSMakeRange(0, 5)];
    self=[self stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    self=[self stringByAppendingString:@"日"];
    return self;
}

- (NSString*)soapMessage:(NSString *)key,...
{
    NSString *akey;
    va_list ap;
    va_start(ap, key);
    NSString *obj = nil;
    if (key) {
        if ([key rangeOfString:@"<"].length == 0)
            obj=[NSString stringWithFormat:@"<%@>%@</%@>",key,@"%@",key];
        else
            obj = key;
        
        while (obj&&(akey=va_arg(ap,id))) {
            if ([akey rangeOfString:@"<"].length == 0)
                obj=[obj stringByAppendingFormat:@"<%@>%@</%@>",akey,@"%@",akey];
            else
                obj = [obj stringByAppendingString:akey];
        }
        va_end(ap);
    }
    
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><soap:%@>%@</soap:%@></soap:Body></soapenv:Envelope>",self,obj?obj:@"",self];;
}
@end
