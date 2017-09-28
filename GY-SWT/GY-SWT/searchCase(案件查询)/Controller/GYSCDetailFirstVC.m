//
//  GYSCDetailFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCDetailFirstVC.h"
#import "MXConstant.h"
#import "GYSCSpDetailModel.h"

NSString *cbbmStr;

@interface GYSCDetailFirstVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *dqjdLabel;
@property (strong, nonatomic) IBOutlet UILabel *lbLabel;
@property (strong, nonatomic) IBOutlet UILabel *ajlyLabel;
@property (strong, nonatomic) IBOutlet UILabel *larqLabel;
@property (strong, nonatomic) IBOutlet UILabel *labmLabel;
@property (strong, nonatomic) IBOutlet UILabel *larLabel;
@property (strong, nonatomic) IBOutlet UILabel *laayLabel;
@property (strong, nonatomic) IBOutlet UILabel *sarqLabel;
@property (strong, nonatomic) IBOutlet UILabel *cbbmLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssbdLabel;
@property (strong, nonatomic) IBOutlet UILabel *jarqLabel;
@property (strong, nonatomic) IBOutlet UILabel *jafsLabel;
@property (strong, nonatomic) IBOutlet UILabel *jaayLabel;

@end

@implementation GYSCDetailFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    [self loaddetailData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loaddetailData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"==%@--%@",json,params);
        [MBProgressHUD hideHUDForView:self.view];
        GYSCSpDetailModel *spDetailModel = [GYSCSpDetailModel mj_objectWithKeyValues:json[@"parameters"][@"ajjbxx"]];
        self.ahqcLabel.text = spDetailModel.ahqc;
        self.dqjdLabel.text = @"庭审阶段";
        self.lbLabel.text = spDetailModel.ajlbmc;
        self.ajlyLabel.text = spDetailModel.ajlymc;
        self.larqLabel.text = spDetailModel.larq;
        self.labmLabel.text = spDetailModel.labmmc;
        self.laayLabel.text = spDetailModel.laaymc;
        self.larLabel.text = spDetailModel.larmc;
        self.sarqLabel.text = spDetailModel.szrq;
        self.cbbmLabel.text = spDetailModel.cbbm;
        cbbmStr = spDetailModel.cbbm;
        self.ssbdLabel.text = [NSString stringWithFormat:@"%ld(万元)",(long)spDetailModel.gsbd];
        self.jarqLabel.text = spDetailModel.jarq;
        self.jafsLabel.text = spDetailModel.jafsmc;
        self.jaayLabel.text = spDetailModel.jaaymc;
    } failure:^(NSError *error) {
        
    }];
}

@end
