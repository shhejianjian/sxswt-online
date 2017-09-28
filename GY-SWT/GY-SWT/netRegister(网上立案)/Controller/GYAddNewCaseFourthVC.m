//
//  GYAddNewCaseFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewCaseFourthVC.h"
#import "MXConstant.h"
#import "GYAddNCPushSecondVC.h"
#import "UIViewController+KNSemiModal.h"
#import "GYNRDlrXxCell.h"
#import "GYAddNewCaseFifthVC.h"

static NSString *ID=@"GYNRDlrXxCell";

@interface GYAddNewCaseFourthVC () <GYAddNCPushSecondVCDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *addNewInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic, strong) GYAddNCPushSecondVC *pushView;
@property (nonatomic, strong) NSMutableArray *dlrXxListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation GYAddNewCaseFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUI {
    self.mxNavigationItem.title = @"核对代理人信息";
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRDlrXxCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadTableViewData];
}

- (void)passValueForWtrName:(NSString *)name AndWtrId:(NSString *)ID Andlszjh:(NSString *)lszjh AndDlrName:(NSString *)dlrName AndDlrSjhm:(NSString *)dlrSjhm AndDlrSfzhm:(NSString *)dlrSfzhm AndJlid:(NSString *)jlid AndSfdzsd:(BOOL)sfdzsd{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"jlid"] = jlid;
    params[@"wtrid"] = ID;
    params[@"wtrmc"] = name;
    params[@"mc"] = dlrName;
    params[@"sfzjhm"] = dlrSfzhm;
    params[@"ydhm"] = dlrSjhm;
    params[@"lszh"] = lszjh;
    
    params[@"sfdzsd"] = [NSString stringWithFormat:@"%d",sfdzsd];
    
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_saveDlrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            [self loadTableViewData];
            self.pushView.wtrNameTextField.text = @"";
            self.pushView.sfzhmTextField.text = @"";
            self.pushView.dlrsjTextField.text = @"";
            self.pushView.dlrmcTextField.text = @"";
            self.pushView.lszjhTextField.text = @"";
            self.pushView.sdBtn.selected = NO;
            [self dismissSemiModalView];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadTableViewData {
    [self.dlrXxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_detailDlrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYNRDlrXxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNRDlrXxModel *dlrModel in arr) {
            [self.dlrXxListArr addObject:dlrModel];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.dlrXxListArr.count;
    
}


- (GYNRDlrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRDlrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRDlrXxCell alloc]init];
        
    }
    cell.dlrModel = self.dlrXxListArr[indexPath.row];

    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 115;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GYNRDlrXxModel *dlrModel = self.dlrXxListArr[indexPath.row];
    self.pushView.updateModel = dlrModel;
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
    self.pushView.ajbsStr = self.ajbsStr;
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
//    if (self.dlrXxListArr.count == 0) {
//        [MBProgressHUD showError:@"请先核对代理人信息"];
//    } else {
        GYAddNewCaseFifthVC *addNCFifthVC = [[GYAddNewCaseFifthVC alloc]init];
        addNCFifthVC.ajbsStr = self.ajbsStr;
        [self.navigationController pushViewController:addNCFifthVC animated:YES];
//    }
}

- (GYAddNCPushSecondVC *)pushView
{
    if (!_pushView) {
        _pushView = [[GYAddNCPushSecondVC alloc] initWithNibName:@"GYAddNCPushSecondVC" bundle:nil];
    }
    _pushView.delegate = self;
    return _pushView;
}
- (NSMutableArray *)dlrXxListArr {
	if(_dlrXxListArr == nil) {
		_dlrXxListArr = [[NSMutableArray alloc] init];
	}
	return _dlrXxListArr;
}

@end
