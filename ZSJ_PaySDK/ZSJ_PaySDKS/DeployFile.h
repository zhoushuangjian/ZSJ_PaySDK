//
 /* 该文件是配置文件，主要设置工程规定不变的参数*/
//
//  Created by 周双建 on 16/1/11.
//  Copyright © 2016年 周双建. All rights reserved.
//

#ifndef DeployFile_h
#define DeployFile_h

/************************支付宝参数***********************/

// 支付宝：参数————公钥
#define   Alipay_publickey    @"2088021638568580"

// 支付宝：参数————私钥 （用于签名）

#define   Alipay_privatekey   @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOQKZ01ZjJxAMKafSbYklPTzcapHmYmYW4L2JjqeXZBNlHtsKMPBuaAWd+vqMLJVNO+qyoMKaaQHHgOtgqRC+cwYYviw/xLTMQIVe1Pv38NUL4i5hF7v2djpOyCn6XZHJbmBy4eFBUOAhBrDKDFq3C0lecfgVBv8iXeyAqWXudgxAgMBAAECgYEAvIpheJFmcTWdQ9YFEsRSJ+gzfS7vodTHLJMpbmPLRejur9DwL1G3kMWi5vncw0UxnEpgX1G3oDeGOFI35mm9rtI1qVPQESnmuRX6eQVoUKBgX/bFCIUneSxNmy036/Ax6VNQj6gq11M4d1fxlq2w1SvyIKUluetiMW2O5kIurMUCQQD8xIk+3SFY/EBjYwyN1V3OaK2k1Rh56quJEdIsOIex3jJ0j0sJoeSdRDehATDYGWZkCtF1XNF76A9+liLcjGdXAkEA5vTrpbyul40C6P3Urkis7Ry7fxiIP8zk8wLRbgSPgXET2hBuKXZH3Vl93YiCZxlMPU9S/BfVXIBU0TQcG9UvtwJASyipYp7gDpSbFLJcBkR+aySnFU8jwwSrUsuQwgNhHdtjB1OgTVHtJ3IkVGSFQIx07KRm2c3qoDxFdy9vWEMLawJBAOOtAjiqXnrr+bhxsh31avN8ZaGPL5GljPW7C3YnbMiwDl/j3pVlEsc0l42yKssz9yJhdm8pl53OrM5nTmZprNUCQQDUCG5q+v4A0cg5c+PebFFhDfeaoGF6BNacu+hsJ+IKKmL/nmm8kasIacTS6sOhxgNA7e2Zt1rQQZdv9UmZtpXg"
// 支付宝：参数—————商户ID

#define  Alipay_seller   @"koolpei@koolpei.com"

// 支付宝：参数—————回调网址(通知网址)
#define Alipay_notifyURL  @"http://zf.koolpei.com:8085/notify_url.aspx"

// 支付宝：参数—————URLTypescheme(info.plist URLType 里面的保持一致)

#define Alipay_scheme   @"ZSJ_AlipaySDK"




/***************************微信支付参数**************************/

// 微信：参数—————— 注册参数APPID （此参数非常重要，不要忘记）
#define WeChat_App_ID    @"wxdd237c0577ce50ce"

// 微信：参数———————安全API(切记：它和MCH（商户标示不一样)
#define WeChat_APP_SECRET  @"yangchenhuizhoushuangjian2016011"

// 微信：参数——————商户ID
#define WeChat_MCH_ID  @"1282431701"

// 微信：参数——————支付回调网址
#define WeChat_NOTIFY_URL  @"http://123.57.190.51:8003/WXPayService.svc/DoWork"
// 微信：参数—————— 版本描述appdesc 应用附加信息

#define WeChat_appdesc   @"WeChatPay_ZSJ"

#endif /* DeployFile_h */
