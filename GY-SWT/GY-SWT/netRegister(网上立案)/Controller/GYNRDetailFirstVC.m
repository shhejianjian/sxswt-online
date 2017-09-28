//
//  GYNRDetailFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailFirstVC.h"
#import "MXConstant.h"
#import "GYNetRegistModel.h"
@interface GYNRDetailFirstVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITextField *courtName;
@property (strong, nonatomic) IBOutlet UITextField *ajlbName;
@property (strong, nonatomic) IBOutlet UITextField *spcxName;
@property (strong, nonatomic) IBOutlet UITextField *personName;
@property (strong, nonatomic) IBOutlet UITextField *number;
@property (strong, nonatomic) IBOutlet UITextField *telephone;

@end

@implementation GYNRDetailFirstVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView.layer.cornerRadius = 5;
    
    
    [self loadWslaAjxxDetailInfo];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadWslaAjxxDetailInfo{
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"wsla_ajxx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_detailInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYNetRegistModel *nrModel = [GYNetRegistModel mj_objectWithKeyValues:json[@"parameters"][@"jbxx"]];
        self.courtName.text = nrModel.fymc;
        self.ajlbName.text = nrModel.ajlbmc;
        self.spcxName.text = nrModel.spcxmc;
        self.personName.text = nrModel.sqrmc;
        self.number.text = nrModel.sqryddh;
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];
    }];
}


@end
