//
//  ZSJ_All_PaySDK.h
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DeployFile.h"
// 这是支付宝，回调信息
typedef void (^result)(id resultObject);

@interface ZSJ_All_PaySDK : NSObject
// 初始化单利
+(ZSJ_All_PaySDK*)ZSJ_PaySdk;
// 检测公钥和私钥是否存在
-(BOOL)ZSJExamine;
// 支付信息的配置
// 订单号
@property(nonatomic,strong) NSString * P_tradeNO ;
// 产品的名字
@property(nonatomic,strong) NSString * P_productName;
// 产品描述
@property(nonatomic,strong) NSString * P_productDescription;
// 要支付的钱数
@property(nonatomic,strong) NSString * P_amount;
// 进行支付
-(void)ZSJ_Pay:(result)resultObject;
/******************************************/
// 微信支付
// 初始化单利
+(ZSJ_All_PaySDK*)ZSJ_WXPaySdk;
//微信检测
-(BOOL)ZSJExamine_WeChat;

// 支付信息的配置
// 订单号
@property(nonatomic,strong) NSString * WeChat_tradeNO ;
// 产品的名字
@property(nonatomic,strong) NSString * WeChat_productName;
// 产品描述
@property(nonatomic,strong) NSString * WeChat_productDescription;
// 要支付的钱数(是以份进行支付的)
@property(nonatomic,strong) NSString * WeChat_amount;
// 参数配置
// 发起支付
-(void)WeChat_SendPay;
@end
