//
//  GYSearchCaseLoginVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/10.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSearchCaseLoginVC.h"
#import "MXConstant.h"
#import "GYSearchCaseListVC.h"


#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.width - (double )320) < DBL_EPSILON )



@interface GYSearchCaseLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *SPSearchBtn;
@property (strong, nonatomic) IBOutlet UIButton *ZXSearchBtn;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *userLoginBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoYConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoWidthConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userNameHeight;

@end

@implementation GYSearchCaseLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-案件信息查询",fyjc];
    self.SPSearchBtn.layer.cornerRadius = 5;
    self.ZXSearchBtn.layer.cornerRadius = 5;
    self.userLoginBtn.layer.cornerRadius = 5;
    
    if (IS_IPHONE_5 == 1) {
        self.logoYConstraint.constant = -160;
        self.logoWidthConstraint.constant = 90;
        self.logoHeightConstraint.constant = 100;
        self.userNameHeight.constant = 20;
    }
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)spSearchClick:(id)sender {
    [self loginHttpWithAjType:@"2" andType:@"2"];
}

- (IBAction)zxSearchClick:(id)sender {
    [self loginHttpWithAjType:@"1" andType:@"2"];
}
- (IBAction)userLoginClick:(id)sender {
    [self loginHttpWithAjType:@" " andType:@"1"];
}


- (void)loginHttpWithAjType:(NSString *)ajType andType:(NSString *)type {
    
    if (self.userName.text.length == 0) {
        [MBProgressHUD showError:@"账号不能为空"];
        return;
    }
    if (self.password.text.length == 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    
    [MBProgressHUD showMessage:@"正在登录" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = self.userName.text;
    params[@"password"] = self.password.text;
    params[@"type"] = type;
    params[@"ajType"] = ajType;
    [GYHttpTool post:ajxcLoginUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        [MBProgressHUD hideHUDForView:self.view];
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        
        if ([loginModel.success isEqualToString:@"true"]) {
            [MBProgressHUD showSuccess:loginModel.msg];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.ticket forKey:@"ajcx_loginTicket"];
            GYSearchCaseListVC *scLiftVC = [[GYSearchCaseListVC alloc]init];
            scLiftVC.ajTypeStr = ajType;
            [self.navigationController pushViewController:scLiftVC animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

@end
