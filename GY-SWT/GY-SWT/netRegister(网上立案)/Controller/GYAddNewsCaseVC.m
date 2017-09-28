//
//  GYAddNewsCaseVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewsCaseVC.h"
#import "GYAddNewCaseSecondVC.h"
#import "MXConstant.h"
#import "GYCourtListModel.h"

@interface GYAddNewsCaseVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UITextField *courtNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sqrNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sqrdhTextField;
@property (strong, nonatomic) IBOutlet UITextField *sqrsjTextField;
@property (strong, nonatomic) IBOutlet UIView *chooseCourtView;
@property (nonatomic, strong) NSMutableArray *courtListArr;
@property (nonatomic, strong) NSMutableArray *courtNameArr;

@property (nonatomic, copy) NSString *chooseCourtDmStr;
@property (nonatomic, copy) NSString *chooseCourtNameStr;

@end

@implementation GYAddNewsCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self loadCourtData];
    // Do any additional setup after loading the view from its nib.
}

- (void) setUI {
    self.mxNavigationItem.title = @"核对案件信息";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.stepView.layer.cornerRadius = 2.5f;
    self.stepView.layer.masksToBounds = YES;
    self.blackLineView.layer.cornerRadius = 5;
    self.blackLineView.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 15;
    self.sureBtn.layer.masksToBounds = YES;
    
    NSString *courtName = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_name"];
    self.courtNameTextField.text = courtName;
    self.courtNameTextField.delegate = self;
    [self.courtNameTextField addTarget:self action:@selector(chooseCourt) forControlEvents:UIControlEventAllTouchEvents];
}

- (IBAction)sureBtnClick:(id)sender {
    
    if (self.sqrNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"申请人姓名不能为空"];
        return;
    }
    if (self.sqrdhTextField.text.length == 0 && self.sqrsjTextField.text.length == 0) {
        [MBProgressHUD showError:@"至少填写一个联系方式"];
        return;
    }
    if (self.sqrsjTextField.text.length != 0) {
        if ([GYCheckInfoTool checkTelephone:self.sqrsjTextField.text] == 0) {
            [MBProgressHUD showError:@"申请人手机填写不正确"];
            return;
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = @"";
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    params[@"fymc"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_name"];
    params[@"ajlb"] = @"2";
    params[@"ajlbmc"] = @"民事";
    params[@"spcx"] = @"1";
    params[@"spcxmc"] = @"一审";
    params[@"ajlylx"] = @"1";
    params[@"ajly"] = @"1";
    params[@"sqryddh"] = self.sqrsjTextField.text;
    params[@"sqrmc"] = self.sqrNameTextField.text;
    params[@"sqrdh"] = self.sqrdhTextField.text;
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_oneStepUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            GYAddNewCaseSecondVC *addNCSecondVC = [[GYAddNewCaseSecondVC alloc]init];
            addNCSecondVC.ajbsStr = loginModel.ajbs;
            [self.navigationController pushViewController:addNCSecondVC animated:YES];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)chooseCourt{
    self.chooseCourtView.hidden = NO;
    self.mxNavigationBar.hidden = YES;
}


- (void)loadCourtData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [GYHttpTool post:courtUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYCourtListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYCourtListModel *courtModel in arr) {
            if ([courtModel.dm hasPrefix:@"O1"]) {
                [self.courtNameArr addObject:courtModel.fyjc];
                [self.courtListArr addObject:courtModel];
            }
        }
        [self loadButtonWithArray:self.courtNameArr];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadButtonWithArray:(NSArray *)arr{
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 40;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        button.backgroundColor = bottonBackgroundBlueColor;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(15 + w, h, KScreenW-30, 30);
        //当button的位置超出屏幕边缘时换行
        if(10 + w + (KScreenW/3-20) > KScreenW-20){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(15 + w, h, KScreenW-30, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self.chooseCourtView addSubview:button];
    }
}

- (void)handleClick:(UIButton *)btn{
    GYCourtListModel *courtListModel = self.courtListArr[btn.tag];
    NSLog(@"%@",courtListModel.dm);
    self.chooseCourtDmStr = courtListModel.dm;
    self.chooseCourtNameStr = courtListModel.dmms;
    self.courtNameTextField.text = courtListModel.dmms;
    self.chooseCourtView.hidden = YES;
    self.mxNavigationBar.hidden = NO;
}

- (IBAction)courtViewBackBtn:(id)sender {
    self.chooseCourtView.hidden = YES;
    self.mxNavigationBar.hidden = NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.courtNameTextField) {
        return NO;
    } else {
        return YES;
    }
    
}

- (NSMutableArray *)courtListArr {
	if(_courtListArr == nil) {
		_courtListArr = [[NSMutableArray alloc] init];
	}
	return _courtListArr;
}

- (NSMutableArray *)courtNameArr {
	if(_courtNameArr == nil) {
		_courtNameArr = [[NSMutableArray alloc] init];
	}
	return _courtNameArr;
}

@end
