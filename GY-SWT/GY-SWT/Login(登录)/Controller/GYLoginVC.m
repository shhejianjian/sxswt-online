//
//  GYLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYLoginVC.h"
#import "MXConstant.h"
#import "GYRegistVC.h"
#import "GYNetRegistVC.h"
#import "GYLoginModel.h"


@interface GYLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *regiestBtn;

@property (strong, nonatomic) IBOutlet UITextField *userNameTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation GYLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-网上立案",fyjc];
    self.loginBtn.layer.cornerRadius = 5;
    self.regiestBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)registBtnClick:(id)sender {
    GYRegistVC *registVC = [[GYRegistVC alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)loginBtnClick:(id)sender {
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginUserType"] = @"1";
    params[@"appLoginName"] = self.userNameTextFiled.text;
    params[@"appPassword"] = self.passwordTextField.text;
    [GYHttpTool post:wsla_loginUrl ticket:@"" params:params success:^(id json) {
        
        NSLog(@"%@---%@",json,params);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            NSLog(@"ticket:%@",loginModel.ticket);
            [MBProgressHUD showSuccess:loginModel.msg];
            GYNetRegistVC *nrHomeVC = [[GYNetRegistVC alloc]init];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"login_ticket"];
            [self.navigationController pushViewController:nrHomeVC animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
