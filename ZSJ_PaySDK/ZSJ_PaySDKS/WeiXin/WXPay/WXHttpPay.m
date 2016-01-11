//
//  WXHttpPay.m
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "WXHttpPay.h"
#import "WApiXML.h"
#import "WXEncrypt.h"
#import "WXApi.h"
@implementation WXHttpPay
//初始化函数
+(WXHttpPay*) init:(NSString *)app_id mch_id:(NSString *)mch_id;
{
    static WXHttpPay * WX = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        WX = [[[self class] alloc] initWith:app_id mach:mch_id];
    });
    return WX;
    }
-(id)initWith:(NSString*)app_id mach:(NSString*)mach{
    if ([super init]) {
        //初始构造函数
        PayUrl     = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
        if (debugInfo == nil){
            debugInfo   = [NSMutableString string];
        }
        [debugInfo setString:@""];
        appid   = app_id;
        mchid   = mach;
    }
    return self;
}
//设置商户密钥
-(void) setKey:(NSString *)key
{
    spkey  = [NSString stringWithString:key];
}
//获取debug信息
-(NSString*) getDebugifo
{
    NSString    *res = [NSString stringWithString:debugInfo];
    [debugInfo setString:@""];
    return res;
}
//获取最后服务返回错误代码
-(long) getLasterrCode
{
    return last_errcode;
}
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    NSLog(@"%@",contentString);
    //添加key字段
    [contentString appendFormat:@"key=%@", APP_SECRET];
    //得到MD5 sign签名
    NSLog(@"%@",contentString);

    NSString *md5Sign =[WXEncrypt  ZSJ_MD5:contentString];
    //输出Debug Info
    [debugInfo appendFormat:@"MD5签名字符串：\n%@\n\n",contentString];
    return md5Sign;
}
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSString *sign;
    NSMutableString *reqPars=[NSMutableString string];
    //生成签名
    sign        = [self createMd5Sign:packageParams];
    //生成xml的package
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>\n"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>\n", categoryId, [packageParams objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign>\n</xml>", sign];
    NSLog(@"%@",reqPars);
    return [NSString stringWithString:reqPars];
}
//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams
{
    NSString *prepayid = nil;
    
    //获取提交支付
    NSString *send      = [self genPackage:prePayParams];
    //输出Debug Info
    [debugInfo appendFormat:@"API链接:%@\n", PayUrl];
    [debugInfo appendFormat:@"发送的xml:%@\n", send];
    //发送请求post xml数据
    NSData *res = [WXEncrypt httpSend:PayUrl method:@"POST" data:send];
    
    //输出Debug Info
    [debugInfo appendFormat:@"服务器返回：\n%@\n\n",[[NSString alloc] initWithData:res encoding:NSUTF8StringEncoding]];
    
    WApiXML *xml  = [[WApiXML alloc]init];
    
    //开始解析
    [xml StartAnalysisData:res];
    // 获取数据
    NSMutableDictionary *resParams = [xml GetAnalysisData];
    
    NSLog(@"关键时刻：%@",resParams);
    
    //判断返回
    NSString *return_code   = [resParams objectForKey:@"return_code"];
    NSString *result_code   = [resParams objectForKey:@"result_code"];
    if ( [return_code isEqualToString:@"SUCCESS"] )
    {
        //生成返回数据的签名
        NSString *sign      = [self createMd5Sign:resParams ];
        NSString *send_sign =[resParams objectForKey:@"sign"] ;
        //验证签名正确性
        if( [sign isEqualToString:send_sign]){
            if( [result_code isEqualToString:@"SUCCESS"]) {
                //验证业务处理状态
                prepayid    = [resParams objectForKey:@"prepay_id"];
                return_code = 0;
                [debugInfo appendFormat:@"获取预支付交易标示成功！\n"];
            }
        }else{
            last_errcode = 1;
            [debugInfo appendFormat:@"gen_sign=%@\n   _sign=%@\n",sign,send_sign];
            [debugInfo appendFormat:@"服务器返回签名验证错误！！！\n"];
        }
    }else{
        last_errcode = 2;
        [debugInfo appendFormat:@"接口返回错误！！！\n"];
    }
    return prepayid;
}

-(void)sendPay_demo
{
    //订单标题，展示给用户
    NSString *order_name    = @"V3";
    //订单金额,单位（分）
    NSString *order_price   = @"1";//1分钱测试
    //================================
    //预付单参数订单设置
    //================================
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    NSLog(@"随机数%@",noncestr);
    NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    [packageParams setObject: appid             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: mchid             forKey:@"mch_id"];      //商户号
    [packageParams setObject: @"APP-001"        forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr          forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"            forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: order_name        forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: NOTIFY_URL        forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: orderno           forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: @"123.12.12.1231"    forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: order_price       forKey:@"total_fee"];       //订单金额，单位为分
    
    //获取prepayId（预支付交易会话标识）
    NSString *prePayid;
    prePayid            = [self sendPrepay:packageParams];
    
    NSLog(@"我的希望：%@",prePayid);
    
    if ( prePayid != nil) {
        //获取到prepayid后进行第二次签名
        
        NSString    *package, *time_stamp, *nonce_str;
        //设置支付参数
        time_t now;
        time(&now);
        time_stamp  = [NSString stringWithFormat:@"%ld", now];
        nonce_str	= [WXEncrypt ZSJ_MD5:noncestr];
        package         = @"Sign=WXPay";
        //第二次签名参数列表
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: appid        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: mchid        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prePayid     forKey:@"prepayid"];
        //生成签名
        NSString *sign  = [self createMd5Sign:signParams];
        //添加签名
        [signParams setObject: sign forKey:@"sign"];
        
        [debugInfo appendFormat:@"第二步签名成功，sign＝%@\n",sign];
        NSMutableString *stamp  = [signParams objectForKey:@"timestamp"];
        //返回参数列表
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = APP_ID;
        req.partnerId           = MCH_ID;
        req.prepayId            = prePayid;
        req.nonceStr            = nonce_str;
        req.timeStamp           = stamp.intValue;
        req.package             = package;
        req.sign                = [signParams objectForKey:@"sign"];
        [WXApi sendReq:req];
          NSLog(@"微信支付执行——appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        NSLog(@"%d",  [WXApi sendReq:req]);
    }else{
        [debugInfo appendFormat:@"获取prepayid失败！\n"];
    }
}
@end
