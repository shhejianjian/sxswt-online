//
//  GYAddNewCaseThirdVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewCaseThirdVC.h"
#import "MXConstant.h"
#import "GYAddNCPushVC.h"
#import "UIViewController+KNSemiModal.h"
#import "GYNRDsrXxCell.h"
#import "GYAddNewCaseFourthVC.h"
#import "GYNRDsrXxModel.h"

static NSString *ID=@"GYNRDsrXxCell";


@interface GYAddNewCaseThirdVC () <GYAddNCPushVCDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *addNewInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) GYAddNCPushVC *pushView;
@property (nonatomic, strong) NSMutableArray *dsrListArr;
@property (nonatomic, strong) NSMutableArray *dsrSfzhmListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation GYAddNewCaseThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.mxNavigationItem.title = @"核对被告信息";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.stepView.layer.cornerRadius = 2.5f;
    self.stepView.layer.masksToBounds = YES;
    self.blackLineView.layer.cornerRadius = 5;
    self.blackLineView.layer.masksToBounds = YES;
    self.addNewInfoBtn.layer.cornerRadius = 15;
    self.addNewInfoBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 15;
    self.nextBtn.layer.masksToBounds = YES;
    [self loadDsrForYgInfo];
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRDsrXxCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadTableViewData];
}


#pragma mark - GYAddNCPushVCDelegate
- (void)passFirstValueForName:(NSString *)name AndSex:(NSString *)sex AndSfzhm:(NSString *)sfzhm AndLxdz:(NSString *)lxdz AndSjhm:(NSString *)sjhm AndSfdzsd:(BOOL)sfdzsd AndSffrsw:(BOOL)sffrdw AndJlid:(NSString *)jlid{
    for (int i = 0;i<self.dsrSfzhmListArr.count; i++) {
        if ([sfzhm isEqualToString:self.dsrSfzhmListArr[i]]) {
            [MBProgressHUD showError:@"此身份证号码已添加至原告"];
            return;
        }
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"jlid"] = jlid;
    params[@"ssdw"] = @"1064020002";
    params[@"ssdwmc"] = @"被告";
    params[@"xbmc"] = sex;
    params[@"xb"] = [self checkSexDMWithSexName:sex];
    params[@"sfzjhm"] = sfzhm;
    params[@"mc"] = name;
    params[@"ydhm"] = sjhm;
    params[@"jtdz"] = lxdz;
    params[@"lxmc"] = @"自然人";
    params[@"lxbm"] = @"1";
    params[@"sfdzsd"] = [NSString stringWithFormat:@"%d",sfdzsd];
    params[@"frdw"] = [NSString stringWithFormat:@"%d",sffrdw];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_saveDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            [self loadTableViewData];
            self.pushView.firstViewNameTextField.text = @"";
            self.pushView.firstViewSfzhmTextField.text = @"";
            self.pushView.firstViewLxdzTextField.text = @"";
            self.pushView.firstViewLxdhTextField.text = @"";
            self.pushView.messageBtn.selected = NO;
            self.pushView.frdwBtn.selected = NO;
            [self dismissSemiModalView];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)passSecondValueForName:(NSString *)name AndZjlx:(NSString *)zjlx AndZjlxmc:(NSString *)zjlxmc AndZjhm:(NSString *)zjhm AndZzmc:(NSString *)zzmc AndDwxz:(NSString *)dwxz AndSjhm:(NSString *)sjhm AndSfdzsd:(BOOL)sfdzsd AndSffrsw:(BOOL)sffrdw AndJlid:(NSString *)jlid{
    for (int i = 0;i<self.dsrSfzhmListArr.count; i++) {
        if ([zjhm isEqualToString:self.dsrSfzhmListArr[i]]) {
            [MBProgressHUD showError:@"此身份证号码已添加至原告"];
            return;
        }
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"jlid"] = jlid;
    params[@"ssdw"] = @"1064020002";
    params[@"ssdwmc"] = @"被告";
    params[@"sfzjhm"] = zjhm;
    params[@"mc"] = name;
    params[@"ydhm"] = sjhm;
    params[@"zzmc"] = zzmc;
    params[@"zjlx"] = zjlx;
    params[@"zjlxmc"] = zjlxmc;
    params[@"dwxz"] = dwxz;
    params[@"lxmc"] = @"法人组织";
    params[@"lxbm"] = @"2";
    params[@"sfdzsd"] = [NSString stringWithFormat:@"%d",sfdzsd];
    params[@"frdw"] = [NSString stringWithFormat:@"%d",sffrdw];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_saveDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            [self loadTableViewData];
            self.pushView.secondViewFrdbmcTextField.text = @"";
            self.pushView.secondViewZzmcTextField.text = @"";
            self.pushView.secondLxdhTextField.text = @"";
            self.pushView.secondViewDwxzTextField.text = @"";
            self.pushView.secondViewZjhmTextField.text = @"";
            self.pushView.secondViewZjlxTextField.text = @"";
            self.pushView.secondMessageBtn.selected = NO;
            self.pushView.secondFrdwBtn.selected = NO;
            [self dismissSemiModalView];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)passThirdValueForZzmc:(NSString *)zzmc AndZzdz:(NSString *)zzdz AndZzdm:(NSString *)zzdm AndDwxz:(NSString *)dwxz AndSjhm:(NSString *)sjhm AndSfdzsd:(BOOL)sfdzsd AndSffrsw:(BOOL)sffrdw AndJlid:(NSString *)jlid{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"jlid"] = jlid;
    params[@"ssdw"] = @"1064020002";
    params[@"ssdwmc"] = @"被告";
    params[@"zzjgdm"] = zzdm;
    params[@"zzmc"] = zzmc;
    params[@"zzdhhm"] = sjhm;
    params[@"zzdz"] = zzdz;
    params[@"dwxz"] = dwxz;
    params[@"lxmc"] = @"非法人组织";
    params[@"lxbm"] = @"3";
    params[@"sfdzsd"] = [NSString stringWithFormat:@"%d",sfdzsd];
    params[@"frdw"] = [NSString stringWithFormat:@"%d",sffrdw];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_saveDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            [self loadTableViewData];
            self.pushView.thirdViewLxdhTextField.text = @"";
            self.pushView.thirdViewDwxzTextField.text = @"";
            self.pushView.thirdViewZzdmTextField.text = @"";
            self.pushView.thirdViewZzdzTextField.text = @"";
            self.pushView.thirdViewZzmcTextField.text = @"";
            self.pushView.thirdFrdwBtn.selected = NO;
            self.pushView.thirdMessageBtn.selected = NO;
            [self dismissSemiModalView];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadDsrForYgInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"ssdw"] = @"1064020001";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    
    [GYHttpTool post:wsla_ajxx_detailDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYNRDsrXxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNRDsrXxModel *dsrModel in arr) {
            NSLog(@"sfzjhm:+++%@",dsrModel.sfzjhm);
            [self.dsrSfzhmListArr addObject:dsrModel.sfzjhm];
        }
    } failure:^(NSError *error) {
        
    }];
}





- (void)loadTableViewData {
    [self.dsrListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"ssdw"] = @"1064020002";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    
    [GYHttpTool post:wsla_ajxx_detailDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYNRDsrXxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNRDsrXxModel *dsrModel in arr) {
            NSLog(@"+++%@",dsrModel.ssdwmc);
            [self.dsrListArr addObject:dsrModel];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}



- (NSString *)checkSexDMWithSexName:(NSString *)sex {
    if ([sex isEqualToString:@"男"]) {
        return @"1000030001";
    }else if ([sex isEqualToString:@"女"]){
        return @"1000030002";
    } else {
        return @"1000030225";
    }
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.dsrListArr.count;
    
}


- (GYNRDsrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRDsrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRDsrXxCell alloc]init];
        
    }
    cell.gynrDsrxxModel = self.dsrListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 110;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GYNRDsrXxModel *dsrModel = self.dsrListArr[indexPath.row];
    self.pushView.updateModel = dsrModel;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [self presentSemiViewController:self.pushView withOptions:@{
                                                                KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                                KNSemiModalOptionKeys.shadowOpacity     : @(0.3)
                                                                }];
    
    
}








- (IBAction)addNewInfoBtnClick:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [self presentSemiViewController:self.pushView withOptions:@{
                                                                KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                                KNSemiModalOptionKeys.shadowOpacity     : @(0.3)
                                                                }];
}
// 按下home键或者双击home键退回界面防止界面狂闪
- (void)applicationWillResignActive:(NSNotification *)notification

{
    [self.pushView dismissSemiModalView];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (IBAction)nextBtnClick:(id)sender {
    if (self.dsrListArr.count == 0) {
        [MBProgressHUD showError:@"请先核对被告信息"];
    } else {
        GYAddNewCaseFourthVC *addNCFourthVC = [[GYAddNewCaseFourthVC alloc]init];
        addNCFourthVC.ajbsStr = self.ajbsStr;
        [self.navigationController pushViewController:addNCFourthVC animated:YES];
        
    }
    
}
- (GYAddNCPushVC *)pushView
{
    if (!_pushView) {
        _pushView = [[GYAddNCPushVC alloc] initWithNibName:@"GYAddNCPushVC" bundle:nil];
    }
    _pushView.delegate = self;
    return _pushView;
}


- (NSMutableArray *)dsrListArr {
	if(_dsrListArr == nil) {
		_dsrListArr = [[NSMutableArray alloc] init];
	}
	return _dsrListArr;
}

- (NSMutableArray *)dsrSfzhmListArr {
	if(_dsrSfzhmListArr == nil) {
		_dsrSfzhmListArr = [[NSMutableArray alloc] init];
	}
	return _dsrSfzhmListArr;
}

@end
