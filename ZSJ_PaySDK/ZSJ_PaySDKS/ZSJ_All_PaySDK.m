//
//  ZSJ_All_PaySDK.m
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "ZSJ_All_PaySDK.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "DataSigner.h"
// 微信头文件
#import "WXApi.h"
#import "WXHttpPay.h"
@implementation ZSJ_All_PaySDK
+(ZSJ_All_PaySDK*)ZSJ_PaySdk{
    static ZSJ_All_PaySDK * PaySdk = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PaySdk = [[[super class] alloc]init];
    });
    return PaySdk;
 }
// 保持唯一
-(id)init{
    if ([super init]) {
        
    }
    return self;
}
// 参数检测
-(BOOL)ZSJExamine{
    if ([Alipay_privatekey length]==0 || [Alipay_publickey length]==0||[Alipay_seller length]==0 ) {
        return NO;
    }else{
        return YES;
    }
}
// 进行支付
-(void)ZSJ_Pay:(result)resultObject{
    Order *order = [[Order alloc] init];
    order.partner = Alipay_publickey;
    order.seller = Alipay_seller;
    order.tradeNO = self.P_tradeNO; //订单ID（由商家自行制定）
    order.productName = self.P_productName; //商品标题
    order.productDescription = self.P_productDescription; //商品描述
    order.amount = self.P_amount; //商品价格
    order.notifyURL =  Alipay_notifyURL; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = Alipay_scheme;
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(Alipay_privatekey);
    NSString *signedString = [signer signString:orderSpec];
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            // 支付结果的回调
            resultObject(resultDic);
         }];
    }
}
/********************************************/
+(ZSJ_All_PaySDK*)ZSJ_WXPaySdk{
    static ZSJ_All_PaySDK * WXPaySdk = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WXPaySdk = [[[super class] alloc]initWeChat];
    });
    return WXPaySdk;
}
-(id)initWeChat{
    if ([super init]) {
        [WXApi registerApp:WeChat_App_ID withDescription:WeChat_appdesc];
    }
    return self;
}
-(BOOL)ZSJExamine_WeChat{
    if ([WXApi isWXAppInstalled]) {
        if ([WXApi isWXAppSupportApi]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        [WXApi getWXAppInstallUrl];
        return NO;
    }
}
// 参数配置
-(void)WeChat_SendPay{
    WXHttpPay * WeiChat = [[WXHttpPay alloc]init];
    WeiChat.WeChat_tradeNO = self.WeChat_tradeNO;
    WeiChat.WeChat_productName = self.WeChat_productName;
    WeiChat.WeChat_productDescription = self.WeChat_productDescription;
    WeiChat.WeChat_amount = self.WeChat_amount;
    [WeiChat sendPay_demo];
}
@end
