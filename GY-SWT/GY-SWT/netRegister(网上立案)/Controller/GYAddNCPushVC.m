//
//  GYAddNCPushVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNCPushVC.h"
#import "XFSegmentView.h"
#import "LQXSwitch.h"
#import "MXConstant.h"
#import "UIViewController+KNSemiModal.h"
#import "SelectAlert.h"
#import "GYDwxzAndZjlxModel.h"

@interface GYAddNCPushVC ()<XFSegmentViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *zjlxListArr;
@property (nonatomic, strong) NSMutableArray *zjlxNameArr;

@property (nonatomic, strong) NSString *zjlxStr;
@property (nonatomic, strong) NSString *checkSexStr;

@end

@implementation GYAddNCPushVC

- (void)viewWillAppear:(BOOL)animated {
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 0, SCREEN_WIDTH, WH(40))];
    segView.delegate = self;
    segView.titles = @[@"自然人",@"法人组织",@"非法人组织"];
    segView.titleFont = Font(15);
    [self.view addSubview:segView];
    [self.view bringSubviewToFront:self.changeValueView];
    if (self.updateModel != nil) {
        self.changeValueView.hidden = NO;
        if ([self.updateModel.lxmc isEqualToString:@"自然人"]) {
            
            self.firstViewNameTextField.text = self.updateModel.mc;
            self.firstViewLxdhTextField.text = self.updateModel.ydhm;
            self.firstViewLxdzTextField.text = self.updateModel.jtdz;
            self.firstViewSfzhmTextField.text = self.updateModel.sfzjhm;
            self.checkSexStr = self.updateModel.xbmc;
            [self checkBtnSelectedWithStr:[NSString stringWithFormat:@"%ld",(long)self.updateModel.sfdzsd] AndBtn:self.messageBtn];
            [self checkBtnSelectedWithStr:self.updateModel.frdw AndBtn:self.frdwBtn];
            [self segmentView:segView didSelectIndex:0];
        } else if ([self.updateModel.lxmc isEqualToString:@"法人组织"]){
            
            self.secondViewFrdbmcTextField.text = self.updateModel.mc;
            self.secondViewDwxzTextField.text = self.updateModel.dwxz;
            self.secondLxdhTextField.text = self.updateModel.ydhm;
            self.secondViewZjhmTextField.text = self.updateModel.sfzjhm;
            self.secondViewZjlxTextField.text = self.updateModel.zjlxmc;
            self.secondViewZzmcTextField.text = self.updateModel.zzmc;
            [self checkBtnSelectedWithStr:[NSString stringWithFormat:@"%ld",(long)self.updateModel.sfdzsd] AndBtn:self.secondMessageBtn];
            [self checkBtnSelectedWithStr:self.updateModel.frdw AndBtn:self.secondFrdwBtn];
            [self segmentView:segView didSelectIndex:1];
        } else if ([self.updateModel.lxmc isEqualToString:@"非法人组织"]){
            
            self.thirdViewDwxzTextField.text = self.updateModel.dwxz;
            self.thirdViewZzmcTextField.text = self.updateModel.zzmc;
            self.thirdViewZzdmTextField.text = self.updateModel.zzjgdm;
            self.thirdViewZzdzTextField.text = self.updateModel.zzdz;
            self.thirdViewLxdhTextField.text = self.updateModel.zzdhhm;
            [self checkBtnSelectedWithStr:[NSString stringWithFormat:@"%ld",(long)self.updateModel.sfdzsd] AndBtn:self.thirdMessageBtn];
            [self checkBtnSelectedWithStr:self.updateModel.frdw AndBtn:self.thirdFrdwBtn];

            [self segmentView:segView didSelectIndex:2];
        }
    } else {
        self.firstViewNameTextField.text = @"";
        self.firstViewLxdhTextField.text = @"";
        self.firstViewLxdzTextField.text = @"";
        self.firstViewSfzhmTextField.text = @"";
        self.secondViewFrdbmcTextField.text = @"";
        self.secondViewDwxzTextField.text = @"";
        self.secondLxdhTextField.text = @"";
        self.secondViewZjhmTextField.text = @"";
        self.secondViewZjlxTextField.text = @"";
        self.secondViewZzmcTextField.text = @"";
        self.thirdViewDwxzTextField.text = @"";
        self.thirdViewZzmcTextField.text = @"";
        self.thirdViewZzdmTextField.text = @"";
        self.thirdViewZzdzTextField.text = @"";
        self.thirdViewLxdhTextField.text = @"";
        self.messageBtn.selected = NO;
        self.frdwBtn.selected = NO;
        self.secondMessageBtn.selected = NO;
        self.secondFrdwBtn.selected = NO;
        self.thirdMessageBtn.selected = NO;
        self.thirdFrdwBtn.selected = NO;
        self.changeValueView.hidden = YES;
        [self segmentView:segView didSelectIndex:0];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.updateModel = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)checkBtnSelectedWithStr:(NSString *)str AndBtn:(UIButton *)Btn{
    if ([str isEqualToString:@"0"]) {
        Btn.selected = NO;
    } else if ([str isEqualToString:@"1"]){
        Btn.selected = YES;
    } else {
        Btn.selected = NO;
    }
}


- (void)setUI{
    //firstView
    self.switchView.layer.cornerRadius = 15;
    self.switchView.layer.masksToBounds = YES;
    self.saveInfoBtn.layer.cornerRadius = 15;
    self.saveInfoBtn.layer.masksToBounds = YES;
    self.messageBtn.layer.borderWidth = 2;
    self.messageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.messageBtn.layer.cornerRadius = 5;
    self.frdwBtn.layer.cornerRadius = 5;
    self.frdwBtn.layer.borderWidth = 2;
    self.frdwBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    //secondView
    self.secondSaveInfoBtn.layer.cornerRadius = 15;
    self.secondSaveInfoBtn.layer.masksToBounds = YES;
    self.secondMessageBtn.layer.borderWidth = 2;
    self.secondMessageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.secondMessageBtn.layer.cornerRadius = 5;
    self.secondFrdwBtn.layer.cornerRadius = 5;
    self.secondFrdwBtn.layer.borderWidth = 2;
    self.secondFrdwBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.secondViewDwxzTextField.delegate = self;
    self.secondViewZjlxTextField.delegate = self;
    self.thirdViewDwxzTextField.delegate = self;
    

    
    [self.secondViewZjlxTextField addTarget:self action:@selector(chooseZjlx) forControlEvents:UIControlEventTouchDown];
    [self.secondViewDwxzTextField addTarget:self action:@selector(chooseSecondDwxz) forControlEvents:UIControlEventTouchDown];
    [self.thirdViewDwxzTextField addTarget:self action:@selector(chooseThirdDwxz) forControlEvents:UIControlEventTouchDown];

    //thirdView
    self.thirdSaveInfoBtn.layer.cornerRadius = 15;
    self.thirdSaveInfoBtn.layer.masksToBounds = YES;
    self.thirdMessageBtn.layer.borderWidth = 2;
    self.thirdMessageBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.thirdMessageBtn.layer.cornerRadius = 5;
    self.thirdFrdwBtn.layer.cornerRadius = 5;
    self.thirdFrdwBtn.layer.borderWidth = 2;
    self.thirdFrdwBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    
    
    LQXSwitch *swit = [[LQXSwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30) onColor:[UIColor colorWithRed:240 / 255.0 green:0 / 255.0 blue:130 / 255.0 alpha:1.0] offColor:[UIColor colorWithRed:0 / 255.0 green:192 / 255.0 blue:246 / 255.0 alpha:1.0] font:[UIFont systemFontOfSize:20] ballSize:30];
    swit.onText = @"女";
    swit.offText = @"男";
    
    if ([self.checkSexStr isEqualToString:@"男"]) {
        [swit setOn:NO animated:YES];
    } else if ([self.checkSexStr isEqualToString:@"女"]) {
        [swit setOn:YES animated:YES];
    }
    [self.switchView addSubview:swit];
    if (swit.on) {
        self.sexStr = swit.onText;
    } else {
        self.sexStr = swit.offText;
    }
    [swit addTarget:self action:@selector(switchSex:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)switchSex:(LQXSwitch *)swit
{
    if (swit.on) {
        self.sexStr = swit.onText;
    } else {
        self.sexStr = swit.offText;
    }
}

//firstView
- (IBAction)messageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)frdwBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)saveInfoBtnClick:(id)sender {
    
    if (self.firstViewNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"姓名不能为空"];
        return;
    }
    if (self.firstViewSfzhmTextField.text.length == 0) {
        [MBProgressHUD showError:@"身份证号码不能为空"];
        return;
    }
    if (self.firstViewLxdzTextField.text.length == 0) {
        [MBProgressHUD showError:@"联系地址不能为空"];
        return;
    }
    if (self.firstViewLxdhTextField.text.length == 0) {
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    if ([GYCheckInfoTool checkTelephone:self.firstViewLxdhTextField.text] == 0) {
        [MBProgressHUD showError:@"手机号码填写不正确"];
        return;
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(passFirstValueForName:AndSex:AndSfzhm:AndLxdz:AndSjhm:AndSfdzsd:AndSffrsw:AndJlid:)]) {
        [self.delegate passFirstValueForName:self.firstViewNameTextField.text AndSex:self.sexStr AndSfzhm:self.firstViewSfzhmTextField.text AndLxdz:self.firstViewLxdzTextField.text AndSjhm:self.firstViewLxdhTextField.text AndSfdzsd:self.messageBtn.selected AndSffrsw:self.frdwBtn.selected AndJlid:self.updateModel.jlid];
    }
    
    
    
}
//secondView
- (IBAction)secondMessageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;

}
- (IBAction)secondFrswBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;

}
- (IBAction)secondSaveInfoBtnClick:(id)sender {
    
    if (self.secondViewFrdbmcTextField.text.length == 0) {
        [MBProgressHUD showError:@"法人代表姓名不能为空"];
        return;
    }
    if (self.secondViewZjlxTextField.text.length == 0) {
        [MBProgressHUD showError:@"证件类型不能为空"];
        return;
    }
    if (self.secondViewZjhmTextField.text.length == 0) {
        [MBProgressHUD showError:@"证件号码不能为空"];
        return;
    }
    if (self.secondViewZzmcTextField.text.length == 0) {
        [MBProgressHUD showError:@"组织名称不能为空"];
        return;
    }
    if (self.secondViewDwxzTextField.text.length == 0) {
        [MBProgressHUD showError:@"单位性质不能为空"];
        return;
    }
    if (self.secondLxdhTextField.text.length == 0) {
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    if ([GYCheckInfoTool checkTelephone:self.secondLxdhTextField.text] == 0) {
        [MBProgressHUD showError:@"手机号码填写不正确"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(passSecondValueForName:AndZjlx:AndZjlxmc:AndZjhm:AndZzmc:AndDwxz:AndSjhm:AndSfdzsd:AndSffrsw:AndJlid:)]) {
        [self.delegate passSecondValueForName:self.secondViewFrdbmcTextField.text AndZjlx:self.zjlxStr AndZjlxmc:self.secondViewZjlxTextField.text AndZjhm:self.secondViewZjhmTextField.text AndZzmc:self.secondViewZzmcTextField.text AndDwxz:self.secondViewDwxzTextField.text AndSjhm:self.secondLxdhTextField.text AndSfdzsd:self.secondMessageBtn.selected AndSffrsw:self.secondFrdwBtn.selected AndJlid:self.updateModel.jlid];
    }
}

- (void)chooseZjlx {
    [self.zjlxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"bxh"] = @"15";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];

    [GYHttpTool post:wsla_dwxzListInfoUrl ticket:ticket params:params success:^(id json) {
        NSArray *arr = [GYDwxzAndZjlxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYDwxzAndZjlxModel *zjlxModel in arr) {
            [self.zjlxListArr addObject:zjlxModel];
            [self.zjlxNameArr addObject:zjlxModel.dmms];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [SelectAlert showWithTitle:@"请选择代表人证件类型" titles:self.zjlxNameArr selectIndex:^(NSInteger selectIndex) {
            GYDwxzAndZjlxModel *zjlxModel = self.zjlxListArr[selectIndex];
            self.zjlxStr = zjlxModel.dm;
        } selectValue:^(NSString *selectValue) {
            self.secondViewZjlxTextField.text = selectValue;
        } showCloseButton:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)chooseSecondDwxz {
    [self.zjlxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"bxh"] = @"14";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];

    [GYHttpTool post:wsla_dwxzListInfoUrl ticket:ticket params:params success:^(id json) {
        NSArray *arr = [GYDwxzAndZjlxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYDwxzAndZjlxModel *zjlxModel in arr) {
            [self.zjlxListArr addObject:zjlxModel.dmms];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [SelectAlert showWithTitle:@"请选择单位性质" titles:self.zjlxListArr selectIndex:^(NSInteger selectIndex) {
        } selectValue:^(NSString *selectValue) {
            self.secondViewDwxzTextField.text = selectValue;
        } showCloseButton:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)chooseThirdDwxz {
    [self.zjlxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"bxh"] = @"14";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];

    [GYHttpTool post:wsla_dwxzListInfoUrl ticket:ticket params:params success:^(id json) {
        NSArray *arr = [GYDwxzAndZjlxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYDwxzAndZjlxModel *zjlxModel in arr) {
            [self.zjlxListArr addObject:zjlxModel.dmms];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [SelectAlert showWithTitle:@"请选择单位性质" titles:self.zjlxListArr selectIndex:^(NSInteger selectIndex) {
        } selectValue:^(NSString *selectValue) {
            self.thirdViewDwxzTextField.text = selectValue;
        } showCloseButton:YES];
    } failure:^(NSError *error) {
        
    }];
}

//thirdView
- (IBAction)thirdMessageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)thirdFrdwBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)thirdSaveInfoBtnClick:(id)sender {
    if (self.thirdViewZzmcTextField.text.length == 0) {
        [MBProgressHUD showError:@"组织名称不能为空"];
        return;
    }
    if (self.thirdViewZzdzTextField.text.length == 0) {
        [MBProgressHUD showError:@"组织地址不能为空"];
        return;
    }
    if (self.thirdViewZzdmTextField.text.length == 0) {
        [MBProgressHUD showError:@"组织代码不能为空"];
        return;
    }
    if (self.thirdViewDwxzTextField.text.length == 0) {
        [MBProgressHUD showError:@"单位性质不能为空"];
        return;
    }
    if (self.thirdViewLxdhTextField.text.length == 0) {
        [MBProgressHUD showError:@"手机号码不能为空"];
        return;
    }
    if ([GYCheckInfoTool checkTelephone:self.thirdViewLxdhTextField.text] == 0) {
        [MBProgressHUD showError:@"手机号码填写不正确"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(passThirdValueForZzmc:AndZzdz:AndZzdm:AndDwxz:AndSjhm:AndSfdzsd:AndSffrsw:AndJlid:)]) {
        [self.delegate passThirdValueForZzmc:self.thirdViewZzmcTextField.text AndZzdz:self.thirdViewZzdzTextField.text AndZzdm:self.thirdViewZzdmTextField.text AndDwxz:self.thirdViewDwxzTextField.text AndSjhm:self.thirdViewLxdhTextField.text AndSfdzsd:self.thirdMessageBtn.selected AndSffrsw:self.thirdFrdwBtn.selected AndJlid:self.updateModel.jlid];
    }
}




-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    
        switch (index) {
            case 0:
                self.secondView.hidden = YES;
                self.firstView.hidden = NO;
                self.thirdView.hidden = YES;
                break;
            case 1:
                self.firstView.hidden = YES;
                self.thirdView.hidden = YES;
                self.secondView.hidden = NO;
                break;
            case 2:
                self.firstView.hidden = YES;
                self.secondView.hidden = YES;
                self.thirdView.hidden = NO;
            default:
                break;
        }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.secondViewZjlxTextField || textField == self.secondViewDwxzTextField || textField == self.thirdViewDwxzTextField) {
        return NO;
    } else {
        return YES;
    }
}


- (NSMutableArray *)zjlxListArr {
	if(_zjlxListArr == nil) {
		_zjlxListArr = [[NSMutableArray alloc] init];
	}
	return _zjlxListArr;
}

- (NSMutableArray *)zjlxNameArr {
	if(_zjlxNameArr == nil) {
		_zjlxNameArr = [[NSMutableArray alloc] init];
	}
	return _zjlxNameArr;
}

@end
