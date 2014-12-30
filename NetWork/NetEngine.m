//
//  NetEngine.m
//  csc
//
//  Created by hetao on 12-11-13.
//
//

#import "NetEngine.h"
#import "JSON.h"
//#import "DDXML.h"
#import "SDDataCache.h"

@implementation NetEngine
static NetEngine *_instance=nil;

+(id)Share
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        _instance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
        _instance.portNumber=[basePort intValue];
        [_instance useCache];

//        [_instance useCache];
    });
	return _instance;
}
+(void) showAlert:(NSString *)theMsg
{
    [ProgressHUD showSuccess:theMsg];
}

+(void)cancel
{
    [ProgressHUD dismiss];
    [[NetEngine Share] cancelAllOperations];
}
#pragma mark - fileAction
+(MKNetworkOperation*) createFileAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               withMask:(NSString *)maskName
{
    return [[NetEngine Share] createFileAction:url onCompletion:completionBlock onError:errorBlock withMask:maskName];
}

-(MKNetworkOperation*) createFileAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               withMask:(NSString *)maskName
{
    DLog(@"%@",url);
    
    if ([[Utility Share] offline]) {
        [ProgressHUD dismiss];
        errorBlock?errorBlock(nil):nil;
        return nil;
    }
    if(maskName!=nil)
        [ProgressHUD show:maskName];
    
    MKNetworkOperation *op = [self operationWithPath:url params:nil httpMethod:@"GET"];
    //[op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {return msg;}forType:@"text/xml"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *responseData=[completedOperation responseData];
        
        if (!responseData) {
            [ProgressHUD showError:@"数据有误"];
            //            [ProgressHUD dismiss];
            [ProgressHUD setAnimationDelay:1.0];            errorBlock?errorBlock(nil):nil;
        }else{
            [ProgressHUD dismiss];
            completionBlock(responseData,NO);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //    [SVProgressHUD dismissWithError:@"网络超时" afterDelay:2];
        [ProgressHUD showError:@"网络超时"];
        //            [ProgressHUD dismiss];
        [ProgressHUD setAnimationDelay:1.0];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op];
    return op;
}

+(MKNetworkOperation*)createFileAction:(NSString*) url
                            withParams:(NSDictionary *)params
                                  file:(NSString *)file
                          withFileType:(NSString *)fileType
                                forKey:(NSString *)fileKey
                          onCompletion:(CurrencyResponseBlock) completionBlock
                               onError:(MKNKErrorBlock) errorBlock
                              withMask:(NSString *)maskName{
    return [[NetEngine Share] createFileAction:url withParams:params file:file withFileType:fileType forKey:fileKey onCompletion:completionBlock onError:errorBlock withMask:maskName];
}
+(MKNetworkOperation*)createDataAction:(NSString*) url
                            withParams:(NSDictionary *)params
                                  data:(NSData *)data
                          withDataType:(NSString *)dataType
                                forKey:(NSString *)dataKey
                              fileName:(NSString *)thefileName
                          onCompletion:(CurrencyResponseBlock) completionBlock
                               onError:(MKNKErrorBlock) errorBlock
                              withMask:(NSString *)maskName{
    return [[NetEngine Share] createDataAction:url withParams:params data:data withDataType:dataType forKey:dataKey fileName:thefileName onCompletion:completionBlock onError:errorBlock withMask:maskName];
}

//自定义带图片的表单上传
- (MKNetworkOperation *) createFileAction:(NSString*) url
                               withParams:(NSDictionary *)params
                                     file:(NSString *)file
                             withFileType:(NSString *)fileType
                                   forKey:(NSString *)fileKey
                             onCompletion:(CurrencyResponseBlock) completionBlock
                                  onError:(MKNKErrorBlock) errorBlock
                                 withMask:(NSString *)maskName
{
    DLog(@"%@",url);
    
    if ([[Utility Share] offline]) {
        [ProgressHUD dismiss];
        errorBlock?errorBlock(nil):nil;
        return nil;
    }
    if(maskName!=nil)
        [ProgressHUD show:maskName];
    //MKNetworkOperation *operation = [engine operationWithPath:@"addPrblem" params:params httpMethod:@"POST"];
    //[operation addFile:imagePath forKey:@"PIMG" mimeType:@"png"];
    //MKNetworkOperation *op = [self operationWithPath:url params:nil httpMethod:@"GET"];
    MKNetworkOperation *op = [self operationWithPath:url params:params httpMethod:@"POST"];
    [op addFile:file forKey:fileKey mimeType:fileType];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *responseData=[completedOperation responseData];
        NSString *responseStringTemp=completedOperation.responseString;

        
        if (!responseStringTemp) {
            //            [SVProgressHUD dismissWithError:@"数据有误"];
            [ProgressHUD showError:@"数据有误"];
            //            [ProgressHUD dismiss];
            [ProgressHUD setAnimationDelay:1.0];
            errorBlock?errorBlock(nil):nil;
        }else{
            [ProgressHUD dismiss];
            completionBlock(responseData,NO);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //        [SVProgressHUD dismissWithError:@"网络超时" afterDelay:2];
        [ProgressHUD showError:@"网络超时"];
        //            [ProgressHUD dismiss];
        [ProgressHUD setAnimationDelay:1.0];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op];
    return op;
}

- (MKNetworkOperation *) createDataAction:(NSString*) url
                               withParams:(NSDictionary *)params
                                     data:(NSData *)data
                             withDataType:(NSString *)DataType
                                   forKey:(NSString *)dataKey
                                 fileName:(NSString *)thefileName
                             onCompletion:(CurrencyResponseBlock) completionBlock
                                  onError:(MKNKErrorBlock) errorBlock
                                 withMask:(NSString *)maskName
{
    DLog(@"%@",url);
    
    if ([[Utility Share] offline]) {
        [ProgressHUD dismiss];
        errorBlock?errorBlock(nil):nil;
        return nil;
    }
    if(maskName!=nil)
        [ProgressHUD show:maskName Interaction:NO];
    //MKNetworkOperation *operation = [engine operationWithPath:@"addPrblem" params:params httpMethod:@"POST"];
    //[operation addFile:imagePath forKey:@"PIMG" mimeType:@"png"];
    //MKNetworkOperation *op = [self operationWithPath:url params:nil httpMethod:@"GET"];
    MKNetworkOperation *op = [self operationWithPath:url params:params httpMethod:@"POST"];
//    [op addData:data forKey:dataKey];
    [op addData:data forKey:dataKey mimeType:DataType fileName:thefileName];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        DLog(@"%@", [completedOperation.readonlyResponse allHeaderFields]);
        //       NSDictionary *fields=[completedOperation.readonlyResponse allHeaderFields];
        //        if (cookie==nil) {
        //            //得到cookie
        //            cookie=[[[fields valueForJSONKey:@"Set-Cookie"]componentsSeparatedByString:@";"]objectAtIndex:0];
        //        }
        //       DLog(@"_________self.cookie:%@",cookie);
        NSString *responseString=completedOperation.responseString;
        if([completedOperation isCachedResponse]) {
            DLog(@"Data from cache");
        }
        else {
            DLog(@"Data from server:%@",responseString);
        }
        if (!responseString) {
            [ProgressHUD showError:@"数据有误"];
            //            [ProgressHUD dismiss];
            [ProgressHUD setAnimationDelay:1.0];
            errorBlock?errorBlock(nil):nil;
        }else{
            [ProgressHUD dismiss];
            //去除首尾的空白和换行字符
            //            responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *HeadSubStr =  [responseString substringFromIndex:1];
            NSString *subStr = [HeadSubStr substringToIndex:HeadSubStr.length-1];
            
            completionBlock([subStr JSONValue],NO);
            /*if (usecache && storeKey) {
             if (!responseString){
             [[SDDataCache sharedDataCache] removeDataForKey:storeKey];
             }else{
             [[SDDataCache sharedDataCache] storeData:[responseString dataUsingEncoding:NSUTF8StringEncoding] forKey:storeKey toDisk:YES];
             }
             }*/
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //        [SVProgressHUD dismissWithError:@"网络超时" afterDelay:2];
        [ProgressHUD showError:@"网络超时"];
        //            [ProgressHUD dismiss];
        [ProgressHUD setAnimationDelay:1.0];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op];
    return op;
}




//MKNetworkOperation *operation = [engine operationWithPath:@"addPrblem" params:params httpMethod:@"POST"];
//[operation addFile:imagePath forKey:@"PIMG" mimeType:@"png"];
//
//[operation addCompletionHandler:^(MKNetworkOperation *completedOperation){
//
//    NSString *returnValue = [completedOperation responseString];
//    returnValue = [returnValue substringFromIndex:10];
//    NSLog(@"returnValue:%@",returnValue);
//    [returnValue substringToIndex:1];
//    NSLog(@"returnValue:%@",returnValue);
//    NSLog(@"[operation responseData]-->>%@", [completedOperation responseString]);
//
//}errorHandler:^(MKNetworkOperation *completedOperation, NSError *error){
//    NSLog(@"MKNetwork request error : %@", [error localizedDescription]);
//}];
//[engine enqueueOperation:operation];


#pragma mark - httpAction
+(MKNetworkOperation*) createHttpAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                               withMask:(NSString *)maskName{
    return [[NetEngine Share] createHttpAction:url onCompletion:completionBlock onError:errorBlock useCache:NO withMask:maskName];
}

-(MKNetworkOperation*) createHttpAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                               withMask:(NSString *)maskName
{
    DLog(@"%@",url);
    
    NSString *storeKey=[url md5];
    if (usecache||[[Utility Share] offline]) {
        if (storeKey) {
            id storedata=[[SDDataCache sharedDataCache] dataFromKey:storeKey fromDisk:YES];
            if (storedata) {
                NSString *datastring=[[NSString alloc] initWithData:storedata encoding:NSUTF8StringEncoding];
                completionBlock([datastring JSONValue],YES);
            }
        }
        if ([[Utility Share] offline]) {
            [ProgressHUD dismiss];
            errorBlock?errorBlock(nil):nil;
            return nil;
        }
    }
    if(maskName!=nil)
        [ProgressHUD show:maskName];
    
    MKNetworkOperation *op = [self operationWithPath:url params:nil httpMethod:@"GET"];
    //[op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {return msg;}forType:@"text/xml"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *responseStringTemp=completedOperation.responseString;
        //对应敬业写的接口(去掉首尾一个字符转换成json格式)
//      NSString *responseString =  [CustomPushAnimation DeleteHeadAndLastChar:responseStringTemp];
        NSString *responseString =  responseStringTemp;


        if([completedOperation isCachedResponse]) {
            DLog(@"Data from cache");
        }
        else {
            DLog(@"Data from server:%@",responseString);
        }
        if (!responseString) {
            //            [SVProgressHUD dismissWithError:@"数据有误"];
            [ProgressHUD showError:@"数据有误"];
            //            [ProgressHUD dismiss];
            [ProgressHUD setAnimationDelay:1.0];
            errorBlock?errorBlock(nil):nil;
        }else{
            DLog(@"%@",[responseString JSONValue]);
            [ProgressHUD dismiss];
            completionBlock([responseString JSONValue],NO);
            if (usecache && storeKey) {
                if (!responseString){
                    [[SDDataCache sharedDataCache] removeDataForKey:storeKey];
                }else{
                    [[SDDataCache sharedDataCache] storeData:[responseString dataUsingEncoding:NSUTF8StringEncoding] forKey:storeKey toDisk:YES];
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //        [SVProgressHUD dismissWithError:@"网络超时" afterDelay:2];
        [ProgressHUD showError:@"网络超时"];
        //            [ProgressHUD dismiss];
        [ProgressHUD setAnimationDelay:1.0];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op];
    return op;
}

+(MKNetworkOperation*) createHttpAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                               withMask:(NSString *)maskName{
    return [[NetEngine Share] createHttpAction:url withParams:params onCompletion:completionBlock onError:errorBlock useCache:usecache withMask:maskName];
}
-(MKNetworkOperation*) createHttpAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                               withMask:(NSString *)maskName
{
    /*
    NSString *storeKey=[url md5];
     if (usecache||[[Utility Share] offline]) {
     if (storeKey) {
     id storedata=[[SDDataCache sharedDataCache] dataFromKey:storeKey fromDisk:YES];
     if (storedata) {
     NSString *datastring=[[NSString alloc] initWithData:storedata encoding:NSUTF8StringEncoding];
     completionBlock([datastring JSONValue],YES);
     }
     }
     if ([[Utility Share] offline]) {
     [ProgressHUD dismiss];
     errorBlock?errorBlock(nil):nil;
     return nil;
     }
     }
     */
    if(maskName!=nil)
        [ProgressHUD show:maskName];
    
    MKNetworkOperation *op = [self operationWithPath:url params:params httpMethod:params?@"POST":@"GET"];
    //    if (cookie) {
    //        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:cookie,@"cookie", nil];
    //        //添加请求头，sessionid
    //        [op addHeaders:dict];
    //    }
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        DLog(@"%@", [completedOperation.readonlyResponse allHeaderFields]);
        //       NSDictionary *fields=[completedOperation.readonlyResponse allHeaderFields];
        //        if (cookie==nil) {
        //            //得到cookie
        //            cookie=[[[fields valueForJSONKey:@"Set-Cookie"]componentsSeparatedByString:@";"]objectAtIndex:0];
        //        }
        //       DLog(@"_________self.cookie:%@",cookie);
        NSString *responseString=completedOperation.responseString;
        if([completedOperation isCachedResponse]) {
            DLog(@"Data from cache");
        }
        else {
            DLog(@"Data from server:%@",responseString);
        }
        if (!responseString) {
            [ProgressHUD showError:@"数据有误"];
            //            [ProgressHUD dismiss];
            [ProgressHUD setAnimationDelay:1.0];
            errorBlock?errorBlock(nil):nil;
        }else{
            [ProgressHUD dismiss];
            //去除首尾的空白和换行字符
//            responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *HeadSubStr =  [responseString substringFromIndex:1];
            NSString *subStr = [HeadSubStr substringToIndex:HeadSubStr.length-1];
            
            completionBlock([subStr JSONValue],NO);
            /*if (usecache && storeKey) {
             if (!responseString){
             [[SDDataCache sharedDataCache] removeDataForKey:storeKey];
             }else{
             [[SDDataCache sharedDataCache] storeData:[responseString dataUsingEncoding:NSUTF8StringEncoding] forKey:storeKey toDisk:YES];
             }
             }*/
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [ProgressHUD showError:@"网络超时"];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
//    [self enqueueOperation:op];
    [self enqueueOperation:op forceReload:!usecache];
    return op;
}
/*
#pragma mark - soapAction
+(MKNetworkOperation*) createAction:(NSString*) msg
                       onCompletion:(CurrencyResponseBlock) completion
{
    return [[NetEngine Share] createAction:msg onCompletion:completion onError:nil useCache:YES withMask:@"正在获取数据"];
}
+(MKNetworkOperation*) createAction:(NSString*) msg
                       onCompletion:(CurrencyResponseBlock) completion
                            onError:(MKNKErrorBlock) error
                           useCache:(BOOL)usecache
                            useMask:(NSString *)maskName
{
    return [[NetEngine Share] createAction:msg onCompletion:completion onError:error useCache:usecache withMask:maskName];
}
 */
 
/*
-(MKNetworkOperation*) createAction:(NSString*) msg
                       onCompletion:(CurrencyResponseBlock) completionBlock
                            onError:(MKNKErrorBlock) errorBlock
                           useCache:(BOOL)usecache
                           withMask:(NSString *)maskName
{
    DLog(@"%@",msg);
    DDXMLDocument *soapdoc = [[DDXMLDocument alloc] initWithXMLString:msg options:0 error:nil];
    NSArray *items = [soapdoc nodesForXPath:@"//soapenv:Body" error:nil];
    NSString *storeKey=((DDXMLElement*)[items objectAtIndex:0]).XMLString;
    if (usecache||[[Utility Share] offline]) {
        if (storeKey) {
            id storedata=[[SDDataCache sharedDataCache] dataFromKey:storeKey fromDisk:YES];
            if (storedata) {
                NSString *datastring=[[NSString alloc] initWithData:storedata encoding:NSUTF8StringEncoding];
                completionBlock([datastring JSONValue],YES);
            }
        }
        if ([[Utility Share] offline]) {
            [ProgressHUD dismiss];
            errorBlock?errorBlock(nil):nil;
            return nil;
        }
    }
    if(maskName!=nil)
        [ProgressHUD showError:maskName];
    
    MKNetworkOperation *op = [self operationWithPath:@"" params:nil httpMethod:@"SOAP"];
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {return msg;}forType:@"text/xml"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *responseString=completedOperation.responseString;
        if([completedOperation isCachedResponse]) {
            DLog(@"Data from cache");
        }
        else {
            DLog(@"Data from server:%@",responseString);
        }
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
        /////解析
        NSString *jsonString=nil;
        NSArray *items = [doc nodesForXPath:@"//soap:Body" error:nil];
        for (DDXMLElement *obj in items) {//循环查询的每条记录
            for(DDXMLNode *node in obj.children){//取得每个字段的值
                for (DDXMLNode *item in node.children) {
                    jsonString=item.stringValue;
                    break;
                }
            }
        }
        if (!doc || !items) {
            [ProgressHUD showError:@"数据有误"];
            [ProgressHUD dismiss];
            errorBlock?errorBlock(nil):nil;
        }else{
            DLog(@"%@",[jsonString JSONValue]);
            [ProgressHUD dismiss];
            completionBlock([jsonString JSONValue],NO);
            if (usecache && storeKey) {
                if (!jsonString){
                    [[SDDataCache sharedDataCache] removeDataForKey:storeKey];
                }else{
                    [[SDDataCache sharedDataCache] storeData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] forKey:storeKey toDisk:YES];
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [ProgressHUD showError:@"网络超时"];
        DLog(@"errorHandler网络超时:%@",msg);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op];
    return op;
}
 */
+ (MKNetworkOperation*)imageAtURL:(NSString *)url size:(CGSize) size onCompletion:(MKNKImageBlock) imageFetchedBlock
{
    if (url) {
        //[NSURL URLWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"]
        //[NSString stringWithFormat:@"http://%@/%@",basePicPath,url]
        //NSString *picPath = [NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        url = [NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        return [[NetEngine Share] imageAtURL:[NSURL URLWithString:url] size:size onCompletion:imageFetchedBlock];
    }
    return nil;
}

+ (MKNetworkOperation*)imageAtURL:(NSString *)url onCompletion:(MKNKImageBlock) imageFetchedBlock
{
    if (url) {
        //[NSURL URLWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"]
        //[NSString stringWithFormat:@"http://%@/%@",basePicPath,url]
        //NSString *picPath = [NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        //        url = [NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        return [[NetEngine Share] imageAtURL:[NSURL URLWithString:url] onCompletion:imageFetchedBlock];
    }
    return nil;
}

//-(NSString*) cacheDirectoryName {
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = paths[0];
//    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"cscImages"];
//    return cacheDirectoryName;
//}
@end
