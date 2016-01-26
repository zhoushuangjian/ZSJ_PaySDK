//
//  APAuthV2Info.h
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/8.
//  Copyright © 2016年 周双建. All rights reserved.
//

//

#import <Foundation/Foundation.h>

@interface APAuthV2Info : NSObject


@property(strong)NSString *apiName;
@property(strong)NSString *appName;
@property(strong)NSString *appID;
@property(strong)NSString *bizType;
@property(strong)NSString *pid;
@property(strong)NSString *productID;
@property(strong)NSString *scope;
@property(strong)NSString *targetID;
@property(strong)NSString *authType;
@property(strong)NSString *signDate;
@property(strong)NSString *service;



- (NSString *)description;


@end
