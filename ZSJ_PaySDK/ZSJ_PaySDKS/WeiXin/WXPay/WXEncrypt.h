//
//  WXEncrypt.h
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXEncrypt : NSObject
//进行MD5加密
+(NSString*)ZSJ_MD5:(NSString*)MD5_Str;
// 哈希加密
+(NSString*)ZSJ_SHA1:(NSString *)SHA1_Str;
/**
 实现http GET/POST 解析返回的json数据
 */
+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data;
@end
