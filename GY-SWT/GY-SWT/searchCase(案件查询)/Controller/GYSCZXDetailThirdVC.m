//
//  GYSCZXDetailThirdVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCZXDetailThirdVC.h"
#import "MXConstant.h"
#import "GYSCSpDetailModel.h"
@interface GYSCZXDetailThirdVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *jasjLabel;
@property (strong, nonatomic) IBOutlet UILabel *jafsLabel;
@property (strong, nonatomic) IBOutlet UILabel *dwbdLabel;

@end

@implementation GYSCZXDetailThirdVC

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
        self.jasjLabel.text = spDetailModel.jarq;
        self.jafsLabel.text = spDetailModel.jafsmc;
        self.dwbdLabel.text = [NSString stringWithFormat:@"%ld(元)",(long)spDetailModel.jabd];
        
    } failure:^(NSError *error) {
        
    }];
}
@end
