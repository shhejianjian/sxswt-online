//
//  GYWssdLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/3/2.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYWssdLoginVC.h"
#import "MXConstant.h"
#import "GYWssdListVC.h"

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.width - (double )320) < DBL_EPSILON )


@interface GYWssdLoginVC ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *userLoginBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoY;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userHeight;

@end

@implementation GYWssdLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-文书送达登录",fyjc];
    self.loginBtn.layer.cornerRadius = 5;
    self.userLoginBtn.layer.cornerRadius = 5;
    
    if (IS_IPHONE_5 == 1) {
        self.logoY.constant = -160;
        self.logoWidth.constant = 90;
        self.logoHeight.constant = 100;
        self.userHeight.constant = 20;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)userLoginBtn:(id)sender {
    [self loginToBookDetailWithType:@"1"];
}



- (IBAction)loginBtnClick:(id)sender {
    [self loginToBookDetailWithType:@"2"];
}


- (void)loginToBookDetailWithType:(NSString *)type {
    if (self.userNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"用户名不能为空"];
        return;
    }
    if (self.passwordTextField.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = self.userNameTextField.text;
    params[@"password"] = self.passwordTextField.text;
    params[@"type"] = type;
    [GYHttpTool post:wssd_loginUrl ticket:@"" params:params success:^(id json) {
        
        NSLog(@"%@---%@",json,params);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            NSLog(@"ticket:%@",loginModel.ticket);
            [MBProgressHUD showSuccess:loginModel.msg];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"wssd_loginTicket"];
            GYWssdListVC *wssdDetail = [[GYWssdListVC alloc]init];
            [self.navigationController pushViewController:wssdDetail animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
