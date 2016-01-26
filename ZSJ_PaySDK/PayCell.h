//
//  PayCell.h
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/11.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Mark_Btn;
@property (weak, nonatomic) IBOutlet UIImageView *Header_ImageV;
@property (weak, nonatomic) IBOutlet UILabel *Name_Label;
@property (weak, nonatomic) IBOutlet UILabel *Despric_Label;

@end
