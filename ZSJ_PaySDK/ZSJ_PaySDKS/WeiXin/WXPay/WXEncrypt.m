//
//  WXEncrypt.m
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "WXEncrypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WXEncrypt
//MD5 加密
+(NSString*)ZSJ_MD5:(NSString *)MD5_Str{
    // 创建一个不变的字符对象
    const char * CHAR_Object = [MD5_Str UTF8String];
    // 无符号数据
    unsigned  char  digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( CHAR_Object, (unsigned int)strlen(CHAR_Object), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];// 32位的字符串
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    return output;
}
+(NSString*)ZSJ_SHA1:(NSString *)SHA1_Str{
    const char *CSHA1 = [SHA1_Str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:CSHA1 length:SHA1_Str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

//http 请求
+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    //设置提交方式
    [request setHTTPMethod:method];
    //设置数据类型
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //设置编码
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    //如果是POST
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error;
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    return response;
}
@end
