//
//  GYRegistVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYRegistVC.h"
#import "MXConstant.h"
#import "GYRegUploadCardIDFirstVC.h"

@interface GYRegistVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextFiel;
@property (strong, nonatomic) IBOutlet UITextField *realNameTextFiel;
@property (strong, nonatomic) IBOutlet UITextField *telephoneTextFiel;
@property (strong, nonatomic) IBOutlet UITextField *cardIDTextFiel;



@end

@implementation GYRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-新用户注册",fyjc];
    self.detailView.layer.cornerRadius = 15;
    self.nextBtn.layer.cornerRadius = 20;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)nextBtnClick:(id)sender {
    if (self.userNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"登录账户不能为空"];
        return;
    }
    if (self.passwordTextFiel.text.length == 0) {
        [MBProgressHUD showError:@"登录密码不能为空"];
        return;
    }
    if (self.realNameTextFiel.text.length == 0) {
        [MBProgressHUD showError:@"真实姓名不能为空"];
        return;
    }
    if (self.telephoneTextFiel.text.length == 0) {
        [MBProgressHUD showError:@"常用手机不能为空"];
        return;
    }
    if ([GYCheckInfoTool checkTelephone:self.telephoneTextFiel.text] == 0) {
        [MBProgressHUD showError:@"常用手机不正确"];
        return;
    }
    if (self.cardIDTextFiel.text.length == 0) {
        [MBProgressHUD showError:@"身份证号不能为空"];
        return;
    }
    if (self.cardIDTextFiel.text.length != 18) {
        [MBProgressHUD showError:@"身份证号不合法"];
        return;
    }
    if ([GYCheckInfoTool cardIDIsCorrect:self.cardIDTextFiel.text] == 0) {
        [MBProgressHUD showError:@"身份证号不合法"];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在注册" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginUserType"] = @"1";
    params[@"loginName"] = self.userNameTextField.text;
    params[@"password"] = self.passwordTextFiel.text;
    params[@"name"] = self.realNameTextFiel.text;
    params[@"sjhm"] = self.telephoneTextFiel.text;
    params[@"sfzjhm"] = self.cardIDTextFiel.text;
    
    [GYHttpTool post:wsla_dsrRegistUrl ticket:@"" params:params success:^(id json) {
        
        NSLog(@"%@---",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            [MBProgressHUD showSuccess:loginModel.msg];
            GYRegUploadCardIDFirstVC *uploadCardIDVC = [[GYRegUploadCardIDFirstVC alloc]init];
            uploadCardIDVC.registIdStr = loginModel.id;
            [self.navigationController pushViewController:uploadCardIDVC animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}


@end
