//
//  GYCourtDetailMainVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCourtDetailMainVC.h"
#import "MXConstant.h"
#import "GYCDSecondCell.h"
#import "GYCDFIfthCell.h"
#import "GYCDThirdCell.h"
#import "GYCDFourthCell.h"
#import "GYSWHModel.h"
#import "GYBmznModel.h"

#define bottomColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:0.9]
#define bottomBtnColor bottomColor(12,59,79)

static NSString *ID2=@"GYCDSecondCell";
static NSString *ID3=@"GYCDThirdCell";
static NSString *ID4=@"GYCDFourthCell";
static NSString *ID5=@"GYCDFIfthCell";


@interface GYCourtDetailMainVC ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *firstBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourthBtn;
@property (strong, nonatomic) IBOutlet UIButton *fifthBtn;
@property (strong, nonatomic) IBOutlet UIWebView *firstView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UIView *secondDetailView;

@property (strong, nonatomic) IBOutlet UIView *thirdView;
@property (strong, nonatomic) IBOutlet UIView *fourthView;
@property (strong, nonatomic) IBOutlet UIView *fifthView;
@property (strong, nonatomic) IBOutlet UITableView *secondTableView;
@property (strong, nonatomic) IBOutlet UITableView *thirdTableView;
@property (strong, nonatomic) IBOutlet UITableView *fourthTableView;
@property (strong, nonatomic) IBOutlet UITableView *fifthTableView;

@property (strong, nonatomic) IBOutlet UILabel *detailViewNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *detailViewBackBtn;
@property (strong, nonatomic) IBOutlet UITextView *detailViewNoteLabel;

@property (nonatomic, strong) NSMutableArray *xgmcListArr;
@property (nonatomic, strong) NSMutableArray *fgmcListArr;

/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;

@end

@implementation GYCourtDetailMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-法院简介",fyjc];
    self.detailViewBackBtn.layer.cornerRadius = 15;
    self.firstView.layer.cornerRadius = 5;
    self.secondView.layer.cornerRadius = 5;
    self.secondDetailView.layer.cornerRadius = 5;
    self.secondTableView.layer.cornerRadius = 5;
    self.thirdView.layer.cornerRadius = 5;
    self.thirdTableView.layer.cornerRadius = 5;
    self.fourthView.layer.cornerRadius = 5;
    self.fourthTableView.layer.cornerRadius = 5;
    self.fifthView.layer.cornerRadius = 5;
    self.fifthTableView.layer.cornerRadius = 5;
    self.firstView.layer.masksToBounds = YES;
    self.secondView.layer.masksToBounds = YES;
    self.thirdView.layer.masksToBounds = YES;
    self.secondDetailView.layer.masksToBounds = YES;
    self.fourthView.layer.masksToBounds = YES;
    self.fifthView.layer.masksToBounds = YES;
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://1.85.16.50:8082/bs/fyjj/getFyjjDetial.shtml?fydm=%@",courtDm]];
    [self.firstView loadRequest:[NSURLRequest requestWithURL:url]];
    self.firstView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.firstView.backgroundColor = [UIColor clearColor];
    self.firstView.opaque = NO;
    
    [self.secondTableView registerNib:[UINib nibWithNibName:@"GYCDSecondCell" bundle:nil] forCellReuseIdentifier:ID2];
    
    [self.thirdTableView registerNib:[UINib nibWithNibName:@"GYCDThirdCell" bundle:nil] forCellReuseIdentifier:ID3];
    
    [self.fourthTableView registerNib:[UINib nibWithNibName:@"GYCDFourthCell" bundle:nil] forCellReuseIdentifier:ID4];
    
    [self.fifthTableView registerNib:[UINib nibWithNibName:@"GYCDFIfthCell" bundle:nil] forCellReuseIdentifier:ID5];
    
    
    self.fourthTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.fourthTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.fourthTableView.mj_header beginRefreshing];
    
    
}
- (void)loadNewData
{
    [self.fgmcListArr removeAllObjects];
    self.currentPage = 1;
    [self loadFourthData];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadFourthData];
}

- (void)loadXgmcListInfoWithType:(NSString *)type {
    [self.xgmcListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
//    [SVProgressHUD showWithStatus:@"正在加载"];
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = courtDm;
    params[@"lx"] = type;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    [GYHttpTool post:xgmc_listInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYSWHModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYSWHModel *swhModel in arr) {
            [self.xgmcListArr addObject:swhModel];
        }
        if ([type isEqualToString:@"5"]) {
            [self.thirdTableView reloadData];

        }
        if ([type isEqualToString:@"1"]) {
            [self.fifthTableView reloadData];

        }
        [MBProgressHUD hideHUDForView:self.view];
//        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadFourthData{
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = courtDm;
    params[@"lx"] = @"6";
    params[@"page"] = @(self.currentPage);
    params[@"pageSize"] = @"8";
    [GYHttpTool post:xgmc_listInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.totalCount = [loginModel.count integerValue];
        NSArray *arr = [GYSWHModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYSWHModel *swhModel in arr) {
            [self.fgmcListArr addObject:swhModel];
        }
        [self.fourthTableView reloadData];
            
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [self.fourthTableView.mj_header endRefreshing];
    [self.fourthTableView.mj_footer endRefreshing];
}


- (void)loadBmznListInfo {
    [self.xgmcListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = courtDm;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    [GYHttpTool post:bmzn_listInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYBmznModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYBmznModel *swhModel in arr) {
            [self.xgmcListArr addObject:swhModel];
        }
        [self.secondTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}





#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == self.fourthTableView) {
        if (self.fgmcListArr.count == self.totalCount) {
            self.fourthTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else{
            self.fourthTableView.mj_footer.state = MJRefreshStateIdle;
        }
        return self.fgmcListArr.count;
    }
    return self.xgmcListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell = nil;
    
    if (tableView == self.secondTableView) {
        GYCDSecondCell *secondcell=[tableView dequeueReusableCellWithIdentifier:ID2];
        
        if (!secondcell) {
            
            secondcell=[[GYCDSecondCell alloc]init];
            
        }
        secondcell.secondSwhModel = self.xgmcListArr[indexPath.row];
        secondcell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = secondcell;
    } else if (tableView == self.thirdTableView){
        GYCDThirdCell *thirdcell=[tableView dequeueReusableCellWithIdentifier:ID3];
        
        if (!thirdcell) {
            
            thirdcell=[[GYCDThirdCell alloc]init];
            
        }
        thirdcell.thirdSwhModel = self.xgmcListArr[indexPath.row];
        thirdcell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = thirdcell;
        
    } else if (tableView == self.fourthTableView) {
        GYCDFourthCell *fourthcell=[tableView dequeueReusableCellWithIdentifier:ID4];
        
        if (!fourthcell) {
            
            fourthcell=[[GYCDFourthCell alloc]init];
            
        }
        if (self.fgmcListArr.count !=0) {
            fourthcell.fourthSwhModel = self.fgmcListArr[indexPath.row];
        }
        fourthcell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = fourthcell;
        
    } else if (tableView == self.fifthTableView) {
        GYCDFIfthCell *fifthcell=[tableView dequeueReusableCellWithIdentifier:ID5];
        
        if (!fifthcell) {
            
            fifthcell=[[GYCDFIfthCell alloc]init];
            
        }
        fifthcell.fifthSwhModel = self.xgmcListArr[indexPath.row];
        fifthcell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = fifthcell;
        
    } else {
        UITableViewCell *tempcell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!tempcell) {
            
            tempcell=[[UITableViewCell alloc]init];
            
        }
        tempcell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = tempcell;
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (tableView == self.secondTableView) {
        return 50;
    } else if (tableView == self.thirdTableView) {
        return 80;
    } else if (tableView == self.fourthTableView) {
        return 100;
    } else if (tableView == self.fifthTableView) {
        return 85;
    }
    return 0;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.secondTableView) {
        self.secondDetailView.hidden = NO;
        self.secondTableView.hidden = YES;
        
        GYBmznModel *bmznModel = self.xgmcListArr[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = bmznModel.id;        
        [GYHttpTool post:bmzn_detailInfoUrl ticket:@"" params:params success:^(id json) {
            NSLog(@"%@",json);
            GYBmznModel *bmznDetailModel = [GYBmznModel mj_objectWithKeyValues:json[@"parameters"][@"bmjzn"]];
            self.detailViewNameLabel.text = bmznDetailModel.organizeName;
            self.detailViewNoteLabel.text = bmznDetailModel.znms;
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}

- (IBAction)backBtnClick:(id)sender {
    self.secondDetailView.hidden = YES;
    self.secondTableView.hidden = NO;
}


- (IBAction)firstBtnClick:(UIButton *)sender {
    self.mxNavigationItem.title = @"法院简介";
    sender.backgroundColor = [UIColor blackColor];
    self.secondBtn.backgroundColor = bottomBtnColor;
    self.thirdBtn.backgroundColor = bottomBtnColor;
    self.fourthBtn.backgroundColor = bottomBtnColor;
    self.fifthBtn.backgroundColor = bottomBtnColor;
    self.firstView.hidden = NO;
    self.secondView.hidden = YES;
    self.thirdView.hidden = YES;
    self.fourthView.hidden = YES;
    self.fifthView.hidden = YES;
    self.secondDetailView.hidden = YES;
}
- (IBAction)secondBtnClick:(UIButton *)sender {
    
    if (self.secondView.hidden == YES) {
        [self loadBmznListInfo];
    }
    
    self.mxNavigationItem.title = @"部门职能";
    sender.backgroundColor = [UIColor blackColor];
    self.firstBtn.backgroundColor = bottomBtnColor;
    self.thirdBtn.backgroundColor = bottomBtnColor;
    self.fourthBtn.backgroundColor = bottomBtnColor;
    self.fifthBtn.backgroundColor = bottomBtnColor;
    self.firstView.hidden = YES;
    self.secondView.hidden = NO;
    self.thirdView.hidden = YES;
    self.fourthView.hidden = YES;
    self.fifthView.hidden = YES;
    self.secondDetailView.hidden = YES;
    self.secondTableView.hidden = NO;
}
- (IBAction)thirdBtnClick:(UIButton *)sender {
    
    if (self.thirdView.hidden == YES) {
        [self loadXgmcListInfoWithType:@"5"];
    }
    
    
    self.mxNavigationItem.title = @"审委会";
    sender.backgroundColor = [UIColor blackColor];
    self.firstBtn.backgroundColor = bottomBtnColor;
    self.secondBtn.backgroundColor = bottomBtnColor;
    self.fourthBtn.backgroundColor = bottomBtnColor;
    self.fifthBtn.backgroundColor = bottomBtnColor;
    self.firstView.hidden = YES;
    self.secondView.hidden = YES;
    self.thirdView.hidden = NO;
    self.fourthView.hidden = YES;
    self.fifthView.hidden = YES;
    self.secondDetailView.hidden = YES;
}
- (IBAction)fourthBtnClick:(UIButton *)sender {
    if (self.fourthView.hidden == YES) {
        
    }
    
    
    self.mxNavigationItem.title = @"法官名册";
    sender.backgroundColor = [UIColor blackColor];
    self.firstBtn.backgroundColor = bottomBtnColor;
    self.thirdBtn.backgroundColor = bottomBtnColor;
    self.secondBtn.backgroundColor = bottomBtnColor;
    self.fifthBtn.backgroundColor = bottomBtnColor;
    self.firstView.hidden = YES;
    self.secondView.hidden = YES;
    self.thirdView.hidden = YES;
    self.fourthView.hidden = NO;
    self.fifthView.hidden = YES;
    self.secondDetailView.hidden = YES;
}
- (IBAction)fifBtnClick:(UIButton *)sender {
    
    if (self.fifthView.hidden == YES) {
        [self loadXgmcListInfoWithType:@"1"];
    }
    
    self.mxNavigationItem.title = @"陪审员";
    sender.backgroundColor = [UIColor blackColor];
    self.firstBtn.backgroundColor = bottomBtnColor;
    self.thirdBtn.backgroundColor = bottomBtnColor;
    self.fourthBtn.backgroundColor = bottomBtnColor;
    self.secondBtn.backgroundColor = bottomBtnColor;
    self.firstView.hidden = YES;
    self.secondView.hidden = YES;
    self.thirdView.hidden = YES;
    self.fourthView.hidden = YES;
    self.fifthView.hidden = NO;
    self.secondDetailView.hidden = YES;
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


- (NSMutableArray *)xgmcListArr {
    if(_xgmcListArr == nil) {
        _xgmcListArr = [[NSMutableArray alloc] init];
    }
    return _xgmcListArr;
}

- (NSMutableArray *)fgmcListArr {
	if(_fgmcListArr == nil) {
		_fgmcListArr = [[NSMutableArray alloc] init];
	}
	return _fgmcListArr;
}

@end
