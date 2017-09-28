//
//  GYAddNCPushSecondVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNCPushSecondVC.h"
#import "UIViewController+KNSemiModal.h"
#import "GYNRDsrXxModel.h"
#import "MXConstant.h"
#import "THPickerView.h"


@interface GYAddNCPushSecondVC () <UITextFieldDelegate>


@property (nonatomic, strong) NSMutableArray *dsrXxListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;


@property (nonatomic, strong) NSMutableArray *dsrNameArr;
@property (nonatomic, strong) NSMutableArray *dsrIdArr;
@property (nonatomic, strong) NSMutableArray *dsrNameListArr;
@property (nonatomic, strong) NSMutableArray *dsrBGNameArr;
@property (nonatomic, strong) NSMutableArray *dsrBGIdArr;
@property (nonatomic, strong) NSMutableArray *dsrBGNameListArr;
@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic, copy) NSString *dlrIdStr;

@end

@implementation GYAddNCPushSecondVC

- (void)viewWillAppear:(BOOL)animated{
    if (self.updateModel != nil) {
        self.wtrNameTextField.text = self.updateModel.wtrmc;
        self.sfzhmTextField.text = self.updateModel.sfzjhm;
        self.dlrsjTextField.text = self.updateModel.ydhm;
        self.dlrmcTextField.text = self.updateModel.mc;
        self.lszjhTextField.text = self.updateModel.lszh;
        [self checkBtnSelectedWithStr:[NSString stringWithFormat:@"%ld",(long)self.updateModel.sfdzsd] AndBtn:self.sdBtn];

    } else {
        self.wtrNameTextField.text = @"";
        self.sfzhmTextField.text = @"";
        self.dlrsjTextField.text = @"";
        self.dlrmcTextField.text = @"";
        self.lszjhTextField.text = @"";
        self.sdBtn.selected = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    self.updateModel = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.saveInfoBtn.layer.cornerRadius = 15;
    self.saveInfoBtn.layer.masksToBounds = YES;
    self.sdBtn.layer.borderWidth = 2;
    self.sdBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.sdBtn.layer.cornerRadius = 5;
    self.wtrNameTextField.delegate = self;
    [self.wtrNameTextField addTarget:self action:@selector(loadWslaAjxxDsrInfo) forControlEvents:UIControlEventTouchDown];
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
- (void)loadWslaAjxxDsrInfo{
    [self.dsrXxListArr removeAllObjects];
    [self.dsrNameListArr removeAllObjects];
    [self.dsrBGNameListArr removeAllObjects];
    [self.dsrNameArr removeAllObjects];
    [self.dsrBGNameArr removeAllObjects];
    [self.dsrIdArr removeAllObjects];
    [self.dsrBGIdArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_detailDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSArray *arr = [GYNRDsrXxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNRDsrXxModel *dsrModel in arr) {
            [self.dsrXxListArr addObject:dsrModel];
            if ([dsrModel.ssdwmc isEqualToString:@"原告"]) {
                if (![dsrModel.mc isEqualToString:@""]) {
                    [self.dsrNameArr addObject:dsrModel.mc];
                    [self.dsrIdArr addObject:dsrModel.jlid];
                }
                if (dsrModel.lxbm == 3) {
                    [self.dsrNameArr addObject:dsrModel.zzmc];
                    [self.dsrIdArr addObject:dsrModel.jlid];
                }
            }
            if ([dsrModel.ssdwmc isEqualToString:@"被告"]) {
                if (![dsrModel.mc isEqualToString:@""]) {
                    [self.dsrBGNameArr addObject:dsrModel.mc];
                    [self.dsrBGIdArr addObject:dsrModel.jlid];
                }
                if (dsrModel.lxbm == 3) {
                    [self.dsrBGNameArr addObject:dsrModel.zzmc];
                    [self.dsrBGIdArr addObject:dsrModel.jlid];
                }
            }
        }
        for (int i = 0; i < self.dsrNameArr.count; i++) {
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.dsrNameArr[i],@"test",self.dsrIdArr[i],@"ID", nil];
            [self.dsrNameListArr addObject:dic];
        }
        for (int i = 0; i < self.dsrBGNameArr.count; i++) {
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.dsrBGNameArr[i],@"test",self.dsrBGIdArr[i],@"ID", nil];
            [self.dsrBGNameListArr addObject:dic];
        }
        
        self.dataArray = @[@{@"test":@"原告",@"datas":self.dsrNameListArr},@{@"test":@"被告",@"datas":self.dsrBGNameListArr}];
        [self showPickViewWithArr:self.dataArray];
        
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        
    }];
}

- (void) showPickViewWithArr:(NSArray *)arr {
    THPickerView *thic = [[THPickerView alloc]initWithDataKey:@"datas" AndDataArray:arr AndTestKey:@"test" AndNumberOfComponents:2];
    [thic showConfirmBlock:^(NSArray<NSString *> *indexArray) {
        for (NSString *strs in indexArray) {

        }
        int k = 999;
        for (int i = 0; i < 1; i++) {
            NSLog(@"===+++%@",indexArray[0]);
            k = [indexArray[1] intValue];
            if ([indexArray[0] isEqualToString:@"0"]) {
                //原告
                self.wtrNameTextField.text = self.dsrNameListArr[k][@"test"];
                self.dlrIdStr = self.dsrNameListArr[k][@"ID"];
            }
            if ([indexArray[0] isEqualToString:@"1"]) {
                //被告
                self.wtrNameTextField.text = self.dsrBGNameListArr[k][@"test"];
                self.dlrIdStr = self.dsrBGNameListArr[k][@"ID"];
            }
        }
        
        
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.wtrNameTextField) {
        return NO;
    } else {
        return YES;
    }
}
- (IBAction)sdBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (IBAction)saveInfoBtnClick:(id)sender {
    if (self.wtrNameTextField.text.length == 0) {
        [MBProgressHUD showError:@"委托人姓名不能为空"];
        return;
    }
    if (self.lszjhTextField.text.length == 0) {
        [MBProgressHUD showError:@"律师证件号不能为空"];
        return;
    }
    if (self.dlrmcTextField.text.length == 0) {
        [MBProgressHUD showError:@"代理人名称不能为空"];
        return;
    }
    if (self.dlrsjTextField.text.length == 0) {
        [MBProgressHUD showError:@"代理人手机号不能为空"];
        return;
    }
    if ([GYCheckInfoTool checkTelephone:self.dlrsjTextField.text] == 0) {
        [MBProgressHUD showError:@"手机号码填写不正确"];
        return;
    }
    if (self.sfzhmTextField.text.length == 0) {
        [MBProgressHUD showError:@"身份证号码不能为空"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(passValueForWtrName:AndWtrId:Andlszjh:AndDlrName:AndDlrSjhm:AndDlrSfzhm:AndJlid:AndSfdzsd:)]) {
        [self.delegate passValueForWtrName:self.wtrNameTextField.text AndWtrId:self.dlrIdStr Andlszjh:self.lszjhTextField.text AndDlrName:self.dlrmcTextField.text AndDlrSjhm:self.dlrsjTextField.text AndDlrSfzhm:self.sfzhmTextField.text AndJlid:self.updateModel.jlid AndSfdzsd:self.sdBtn.selected];
    }
    
    
}


- (NSMutableArray *)dsrXxListArr {
	if(_dsrXxListArr == nil) {
		_dsrXxListArr = [[NSMutableArray alloc] init];
	}
	return _dsrXxListArr;
}

- (NSMutableArray *)dsrNameArr {
	if(_dsrNameArr == nil) {
		_dsrNameArr = [[NSMutableArray alloc] init];
	}
	return _dsrNameArr;
}

- (NSMutableArray *)dsrIdArr {
	if(_dsrIdArr == nil) {
		_dsrIdArr = [[NSMutableArray alloc] init];
	}
	return _dsrIdArr;
}

- (NSMutableArray *)dsrNameListArr {
	if(_dsrNameListArr == nil) {
		_dsrNameListArr = [[NSMutableArray alloc] init];
	}
	return _dsrNameListArr;
}

- (NSMutableArray *)dsrBGNameArr {
	if(_dsrBGNameArr == nil) {
		_dsrBGNameArr = [[NSMutableArray alloc] init];
	}
	return _dsrBGNameArr;
}

- (NSMutableArray *)dsrBGIdArr {
	if(_dsrBGIdArr == nil) {
		_dsrBGIdArr = [[NSMutableArray alloc] init];
	}
	return _dsrBGIdArr;
}

- (NSMutableArray *)dsrBGNameListArr {
	if(_dsrBGNameListArr == nil) {
		_dsrBGNameListArr = [[NSMutableArray alloc] init];
	}
	return _dsrBGNameListArr;
}

@end
