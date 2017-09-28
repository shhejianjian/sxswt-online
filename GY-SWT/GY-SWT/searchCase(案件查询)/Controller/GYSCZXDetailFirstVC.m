//
//  GYSCZXDetailFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCZXDetailFirstVC.h"
#import "MXConstant.h"
#import "GYSCSpDetailModel.h"

@interface GYSCZXDetailFirstVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *ayLabel;
@property (strong, nonatomic) IBOutlet UILabel *larqLabel;
@property (strong, nonatomic) IBOutlet UILabel *laayLabel;
@property (strong, nonatomic) IBOutlet UILabel *zxbdLabel;
@property (strong, nonatomic) IBOutlet UILabel *sqzxrLabel;
@property (strong, nonatomic) IBOutlet UILabel *bzxrLabel;

@end

@implementation GYSCZXDetailFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddetailData];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    
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
        self.ayLabel.text = spDetailModel.ahqc;
        self.larqLabel.text = spDetailModel.larq;
        self.laayLabel.text = spDetailModel.laaymc;
        self.zxbdLabel.text = [NSString stringWithFormat:@"%ld(元)",(long)spDetailModel.gsbd];
        self.sqzxrLabel.text = spDetailModel.dybg;
        self.bzxrLabel.text = spDetailModel.dyyg;
    } failure:^(NSError *error) {
        
    }];
}

@end
