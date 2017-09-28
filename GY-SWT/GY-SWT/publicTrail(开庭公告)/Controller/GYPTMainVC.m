//
//  GYPTMainVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/20.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYPTMainVC.h"
#import "GYNRSegmentView.h"
#import "MXConstant.h"
#import "GYKtggModel.h"
#import "GYWssdListCell.h"

#import "PasswordAlertView.h"


static NSString *ID=@"GYWssdListCell";



@interface GYPTMainVC ()<GYNRSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *ktggListArr;
@property (nonatomic, copy) NSString *dayType;
@property(nonatomic,strong)UIView *bGView;

@property (strong, nonatomic) IBOutlet UIView *detailInfoView;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *realContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *cbrLabel;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;


@end

@implementation GYPTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.backBtn.layer.cornerRadius = 15;
    self.backBtn.layer.masksToBounds = YES;
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-开庭公告",fyjc];
    self.mxNavigationItem.rightItem = [[MXBarButtonItem alloc] initWIthImage:@"搜索" handler:^{
        [self createBackgroundView];
        PasswordAlertView *alert = [[PasswordAlertView alloc] initWithAlertViewHeight:395];
        __weak PasswordAlertView *weakSelf = alert;
        alert.ButtonClick = ^void(UIButton*button){
            [self.bGView removeFromSuperview];
            
            if (button.tag == 2) {
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"ahqc"] = weakSelf.anhaoTextField.text;
                params[@"dsr"] = weakSelf.dsrNameTextField.text;
                params[@"laaymc"] = weakSelf.anyouTextField.text;
                params[@"fbrxm"] = weakSelf.fgNameTextField.text;
                if ([weakSelf.startTimeBtn.titleLabel.text isEqualToString:@"请点击选择开始时间"]) {
                    params[@"xsmtkssj"] = @"";
                } else {
                    params[@"xsmtkssj"] = weakSelf.startTimeBtn.titleLabel.text;
                }
                if ([weakSelf.endTimeBtn.titleLabel.text isEqualToString:@"请点击选择结束时间"]) {
                    params[@"xsmtjssj"] = @"";
                } else {
                    params[@"xsmtjssj"] = weakSelf.endTimeBtn.titleLabel.text;
                }
                params[@"page"] = @"1";
                params[@"pageSize"] = @"100";
                params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];;
                [self loadPublicTalkInfoWithSearchParams:params];
            }
        };
    }];
    GYNRSegmentView *segView=[[GYNRSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, 40)];
    segView.delegate = self;
    segView.titles = @[@"今日开庭",@"明日开庭"];
    segView.titleFont = Font(15);
    [self.view addSubview:segView];
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYWssdListCell" bundle:nil] forCellReuseIdentifier:ID];
    self.dayType = @"0";
    [self loadPublicTalkInfoWithDayType:@"0"];

    // Do any additional setup after loading the view from its nib.
}

- (void)loadPublicTalkInfoWithDayType:(NSString *)dayType {
    [self.ktggListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"intypes"] = dayType;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];;
    [GYHttpTool post:ktgg_listInfoUrl ticket:@"" params:params success:^(id json) {
        
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            if ([loginModel.msg isEqualToString:@"当前没有信息"]) {
                [MBProgressHUD showError:loginModel.msg];
            }
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
        NSArray *arr = [GYKtggModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYKtggModel *ktggModel in arr) {
            [self.ktggListArr addObject:ktggModel];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadPublicTalkInfoWithSearchParams:(NSDictionary *)params {
    [self.ktggListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [GYHttpTool post:ktgg_listInfoUrl ticket:@"" params:params success:^(id json) {
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            if ([loginModel.msg isEqualToString:@"当前没有信息"]) {
                [MBProgressHUD showError:loginModel.msg];
            }
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        NSArray *arr = [GYKtggModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYKtggModel *ktggModel in arr) {
            [self.ktggListArr addObject:ktggModel];
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ktggListArr.count;
}


- (GYWssdListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GYWssdListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYWssdListCell alloc]init];
        
    }
    cell.ktggModel = self.ktggListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myTableView.hidden = YES;
    self.detailInfoView.hidden = NO;
    GYKtggModel *ktggModel = self.ktggListArr[indexPath.row];
    self.ahqcLabel.text = ktggModel.ahqc;
    self.realContentLabel.text = [NSString stringWithFormat:@"        %@",ktggModel.realContent];
    self.cbrLabel.text = ktggModel.fbrxm;
    
}
- (IBAction)hideDetaiInfoView:(id)sender {
    self.myTableView.hidden = NO;
    self.detailInfoView.hidden = YES;
}



-(void)segmentView:(GYNRSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
            if (![self.dayType isEqualToString:@"0"]) {
                [self loadPublicTalkInfoWithDayType:@"0"];
                self.dayType = @"0";
                self.myTableView.hidden = NO;
                self.detailInfoView.hidden = YES;
            }
            
            break;
        case 1:
            if (![self.dayType isEqualToString:@"1"]) {
                [self loadPublicTalkInfoWithDayType:@"1"];
                self.dayType = @"1";
                self.myTableView.hidden = NO;
                self.detailInfoView.hidden = YES;
            }
            break;
        default:
            break;
    }
}

-(void)createBackgroundView{
    self.bGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENwidth, MAINSCREENheight)];
    self.bGView.backgroundColor = [UIColor blackColor];
    self.bGView.alpha = 0.5;
    self.bGView.userInteractionEnabled = YES;
    [WINDOWFirst addSubview:self.bGView];
}


- (NSMutableArray *)ktggListArr {
	if(_ktggListArr == nil) {
		_ktggListArr = [[NSMutableArray alloc] init];
	}
	return _ktggListArr;
}

@end
