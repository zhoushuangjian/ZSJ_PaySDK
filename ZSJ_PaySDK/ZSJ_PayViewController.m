//
//  ZSJ_PayViewController.m
//  ZSJ_PaySDK
//
//  Created by 周双建 on 16/1/11.
//  Copyright © 2016年 周双建. All rights reserved.
//

#import "ZSJ_PayViewController.h"
#import "PayCell.h"
#import "ZSJ_All_PaySDK.h"
@interface ZSJ_PayViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * ImageV_Array ;
    NSArray * Title_Array;
    NSArray * DespricTitle_Array;
    UIButton * All_markBtn;
    int Which_Pay;// 1  支付宝  2 微信
}
@property (weak, nonatomic) IBOutlet UITableView *PayTableview;
- (IBAction)PayBtn:(id)sender;

@end

@implementation ZSJ_PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PayTableview.tableFooterView = [[UIView alloc]init];
    ImageV_Array = [NSArray array];
    Title_Array = [NSArray array];
    DespricTitle_Array = [NSArray array];
    ImageV_Array = @[[UIImage imageNamed:@"ic_pay0"],[UIImage imageNamed:@"ic_pay1"]];
    Title_Array = @[@"支付宝",@"微信"];
    DespricTitle_Array = @[@"支付宝支付，快捷安全",@"微信支付，简单方便"];

    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"请选择支付方式";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CellID = @"ID";
    PayCell * Cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!Cell) {
        Cell = [[[NSBundle mainBundle] loadNibNamed:@"PayCell" owner:nil options:nil] lastObject];
        
    }
    Cell.Header_ImageV.image = ImageV_Array[indexPath.row];
    Cell.Name_Label.text = Title_Array[indexPath.row];
    Cell.Despric_Label.text  = DespricTitle_Array[indexPath.row];
    Cell.Mark_Btn.tag = indexPath.row;
    [Cell.Mark_Btn  addTarget:self action:@selector(ChangClick:) forControlEvents:UIControlEventTouchUpInside];
    return Cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ChangClick:(UIButton*)Btn{
    Btn.selected = NO;
    All_markBtn.selected = NO;
    All_markBtn = Btn;
    All_markBtn.selected = YES;
    switch (Btn.tag) {
        case 0:
            Which_Pay=1;
            break;
        case 1:
            Which_Pay= 2;
            break;
        default:
            break;
    }
    
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PayBtn:(id)sender {
    if (Which_Pay==0) {
        
    }else if(Which_Pay ==1){
        ZSJ_All_PaySDK * pa = [ZSJ_All_PaySDK ZSJ_PaySdk];
        if ([pa ZSJExamine]) {
            pa.P_amount = @"0.01";
            pa.P_productDescription = @"erdan ";
            pa.P_productName = @"sd";
            pa.P_tradeNO = @"KPD20160108104062";
            [pa ZSJ_Pay:^(id resultObject) {
                NSLog(@"%@",resultObject);
            }];
        }
    }else{
        ZSJ_All_PaySDK * pa = [ZSJ_All_PaySDK ZSJ_WXPaySdk];
        if ([pa ZSJExamine_WeChat]) {
            pa.WeChat_amount = @"1";
            pa.WeChat_productDescription = @"你欠我钱";
            pa.WeChat_productName = @"钱";
            pa.WeChat_tradeNO = @"KPD20160108104025";
            [pa WeChat_SendPay];
        }
    }
}
@end
