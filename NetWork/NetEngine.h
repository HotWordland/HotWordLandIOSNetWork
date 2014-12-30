//
//  NetEngine.h
//  csc
//
//  Created by hetao on 12-11-13.
//
//

#import "NSDictionaryCategory.h"
#import "Utility.h"
#import "MKNetworkEngine.h"
#import "StringCategory.h"
#import "ProgressHUD.h"
@interface NetEngine : MKNetworkEngine
typedef void (^CurrencyResponseBlock)(id resData,BOOL isCache);
+(id)Share;
+(void)cancel;
+(void) showAlert:(NSString *)theMsg;
//+(MKNetworkOperation*) createAction:(NSString*) msg
//                          onCompletion:(CurrencyResponseBlock) completion;
//+(MKNetworkOperation*) createAction:(NSString*) msg
//                       onCompletion:(CurrencyResponseBlock) completion
//                            onError:(MKNKErrorBlock) error
//                           useCache:(BOOL)usecache
//                            useMask:(NSString *)maskName;
+(MKNetworkOperation*) createFileAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               withMask:(NSString *)maskName;
+(MKNetworkOperation*) createHttpAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                               withMask:(NSString *)maskName;
+(MKNetworkOperation*) createHttpAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                               withMask:(NSString *)maskName;
+ (MKNetworkOperation*)imageAtURL:(NSString *)url size:(CGSize) size onCompletion:(MKNKImageBlock) imageFetchedBlock;
+ (MKNetworkOperation*)imageAtURL:(NSString *)url onCompletion:(MKNKImageBlock) imageFetchedBlock;

//自定义表单上传
+(MKNetworkOperation*)createFileAction:(NSString*) url
                            withParams:(NSDictionary *)params
                                  file:(NSString *)file
                          withFileType:(NSString *)fileType
                                forKey:(NSString *)fileKey
                          onCompletion:(CurrencyResponseBlock) completionBlock
                               onError:(MKNKErrorBlock) errorBlock
                              withMask:(NSString *)maskName;
///表单上传Data数据-(图片)
+(MKNetworkOperation*)createDataAction:(NSString*) url
                            withParams:(NSDictionary *)params
                                  data:(NSData *)data
                          withDataType:(NSString *)dataType
                                forKey:(NSString *)dataKey
                              fileName:(NSString *)thefileName
                          onCompletion:(CurrencyResponseBlock) completionBlock
                               onError:(MKNKErrorBlock) errorBlock
                              withMask:(NSString *)maskName;
@end
