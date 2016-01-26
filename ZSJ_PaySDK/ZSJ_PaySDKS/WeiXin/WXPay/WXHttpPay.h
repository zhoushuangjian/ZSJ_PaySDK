//
//  WXHttpPay.h
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeployFile.h"
@interface WXHttpPay : NSObject
{
    //lash_errcode;
    long     last_errcode;
    //debug信息
    NSMutableString *debugInfo;
}
// 支付信息的配置
// 订单号
@property(nonatomic,strong) NSString * WeChat_tradeNO ;
// 产品的名字
@property(nonatomic,strong) NSString * WeChat_productName;
// 产品描述
@property(nonatomic,strong) NSString * WeChat_productDescription;
// 要支付的钱数(是以份进行支付的)
@property(nonatomic,strong) NSString * WeChat_amount;
//初始化函数
-(NSString *) getDebugifo;
-(long) getLasterrCode;
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict;
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams;
//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams;
//签名实例测试
- (void)sendPay_demo;
@end
