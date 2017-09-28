//
//  GYHomeVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYHomeVC.h"
#import "CZZCarouselView.h"
#import "MXConstant.h"
#import "CustomerScrollView.h"
#import "UIView+WJExtension.h"
#import "GYHomeCell.h"
#import "GYLoginVC.h"
#import "GYNoticePublicVC.h"
#import "GYCourtDetailMainVC.h"
#import "GYSearchCaseLoginVC.h"
#import "GYPeopleContactVC.h"
#import "GYPTMainVC.h"
#import "GYCourtListModel.h"
#import "GYHttpTool.h"
#import "GYTop2NewsModel.h"
#import "TopMenuSelectViewController.h"
#import "GYNewsNoDetailVC.h"
#import "GYNewsRealDetailVC.h"
#import "GYWssdLoginVC.h"
#import "TOMSMorphingLabel.h"
#import "GYKtggModel.h"
#import "GYReDocumentVC.h"
#import "GYLiveBroadcastVC.h"
#import "GYCourtListCell.h"
#import "GYGuideListVC.h"
#import "GYCourtNaviVC.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.width - (double )320) < DBL_EPSILON )

#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.width - (double )375) < DBL_EPSILON )

#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.width - (double )414) < DBL_EPSILON )


static NSString *ID=@"homeCell";
static NSString *courtCellId=@"GYCourtListCell";


@interface GYHomeVC ()<CZZCarouselViewDelegate,UIScrollViewDelegate,scrollViewButtonDelegate,GYCourtListCellDelegate>
@property (nonatomic,strong)CZZCarouselView *carouselView;
@property (nonatomic,strong) CustomerScrollView * btnScrollView;
@property (nonatomic,strong) NSArray * dataArr;

@property (strong, nonatomic) IBOutlet UIView *myFunKeboardView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIView *homeDetailView;
@property (strong, nonatomic) IBOutlet UIView *courtView;
@property (strong, nonatomic) IBOutlet UITableView *courtTableView;


@property (nonatomic, strong) NSMutableArray *courtListArr;
@property (nonatomic, strong) NSMutableArray *courtNameArr;

@property (nonatomic, strong) NSMutableArray *top2NewsArr;
@property (nonatomic, copy) NSString *imageFileUrl;

@property (nonatomic, strong) NSMutableArray *lunboNewsArr;
@property (nonatomic, copy) NSString *lunboImageFileUrl;
@property (nonatomic, strong) NSMutableArray *lunboTitleArr;
@property (nonatomic, strong) NSMutableArray *lunboImageArr;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *funKeyBoardConstraint;

@property (nonatomic, assign) int lunboViewHeight;
@property (nonatomic, assign) int labelTopConstraintHeight;
@property (nonatomic, assign) int carouselViewHeight;

@property (strong, nonatomic) IBOutlet UILabel *ktggLabel;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, strong) NSMutableArray *ktggNameList;

@property (nonatomic, copy) NSString *checkNetWork;

@end

@implementation GYHomeVC

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    if (courtDm) {
        self.mxNavigationBar.hidden = NO;
        self.courtView.hidden = YES;
        self.homeDetailView.hidden = NO;

    } else {
        self.courtView.hidden = NO;
        self.homeDetailView.hidden = YES;
        self.mxNavigationBar.hidden = YES;
    }
    
}

    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IS_IPHONE_5 == 1) {
        self.lunboViewHeight = 185;
        self.labelTopConstraintHeight = 220;
        self.carouselViewHeight = 150;
    } else if (IS_IPHONE_6 == 1){
        self.lunboViewHeight = 210;
        self.labelTopConstraintHeight = 250;
        self.carouselViewHeight = 180;
    }else if (IS_IPHONE_6_PLUS == 1){
        self.lunboViewHeight = 249;
        self.labelTopConstraintHeight = 280;
        self.carouselViewHeight = 210;
    } else if([[UIScreen mainScreen] bounds].size.width == 768) {
        self.lunboViewHeight = 300;
        self.labelTopConstraintHeight = 470;
        self.carouselViewHeight = 400;
    } else if([[UIScreen mainScreen] bounds].size.width == 1024) {
        self.lunboViewHeight = 400;
        self.labelTopConstraintHeight = 510;
        self.carouselViewHeight = 440;
    }
    
    
    [self observeWorknet];
    
    [self loadCourtData];
    [self loadLunBoNewsInfo];
    [self loadTop2NewsInfo];
    [self loadPublicTalkInfoWithDayType];
    
    
    self.labelTopConstraint.constant = _labelTopConstraintHeight;
    self.funKeyBoardConstraint.constant = self.lunboViewHeight;

    
    self.mxNavigationItem.title = @"陕法院自助服务";
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYHomeCell" bundle:nil] forCellReuseIdentifier:ID];
    [self.courtTableView registerNib:[UINib nibWithNibName:@"GYCourtListCell" bundle:nil] forCellReuseIdentifier:courtCellId];
    
    self.myTableView.bounces = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *titleImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [titleImage setContentMode:UIViewContentModeScaleToFill];
    titleImage.frame = CGRectMake(70, 32, 20, 20);
    self.mxNavigationItem.titleView = titleImage;
    
    [self.myFunKeboardView addSubview:self.btnScrollView];
   
    
    self.idx = 0;
    
    
}
#pragma mark - toggling text
- (void)loadPublicTalkInfoWithDayType {
    [self.ktggNameList removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"intypes"] = @"0";
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];;
    [GYHttpTool post:ktgg_listInfoUrl ticket:@"" params:params success:^(id json) {

        NSArray *arr = [GYKtggModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYKtggModel *ktggModel in arr) {
            [self.ktggNameList addObject:ktggModel.ahqc];
        }
        if (self.ktggNameList.count != 0) {
            [self toggleTextForLabel:self.ktggLabel];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)setIdx:(NSInteger)idx
{
    if (self.ktggNameList.count != 0) {
        _idx = MAX(0, MIN(idx, idx % [self.ktggNameList count]));
    }
    
}

- (void)toggleTextForLabel:(UILabel *)label
{
    if (self.ktggNameList.count != 0) {
        label.text = self.ktggNameList[self.idx++];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self toggleTextForLabel:label];
        });
    }
}

- (void)observeWorknet{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"不可达的网络(未连接)");
                self.courtView.hidden = YES;
                self.checkNetWork = @"yes";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"如无法弹出是否允许该应用使用数据网络弹框，请至设置中开启无线局域网助理即可" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"取消");
                }];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:okAction];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                if ([self.checkNetWork isEqualToString:@"yes"]) {
                    self.courtView.hidden = NO;
                    [self loadCourtData];
                    [self loadLunBoNewsInfo];
                    [self loadTop2NewsInfo];
                    [self loadPublicTalkInfoWithDayType];
                    self.checkNetWork = @"no";
                } else {

                }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                if ([self.checkNetWork isEqualToString:@"yes"]) {
                    self.courtView.hidden = NO;
                    [self loadCourtData];
                    [self loadLunBoNewsInfo];
                    [self loadTop2NewsInfo];
                    [self loadPublicTalkInfoWithDayType];
                    self.checkNetWork = @"no";

                } else {

                }
                
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)loadTop2NewsInfo {
    [self.top2NewsArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    [GYHttpTool post:news_top2InfoUrl ticket:@"" params:params success:^(id json) {

        NSArray *arr = [GYTop2NewsModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYTop2NewsModel *top2NewsModel in arr) {
            [self.top2NewsArr addObject:top2NewsModel];
        }
        
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.imageFileUrl = loginModel.imageServiceUrl;

        if (self.top2NewsArr.count > 0) {
            [self.myTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadLunBoNewsInfo {
    [self.lunboNewsArr removeAllObjects];
    [self.lunboTitleArr removeAllObjects];
    [self.lunboImageArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    [GYHttpTool post:news_tjInfoUrl ticket:@"" params:params success:^(id json) {
        NSArray *arr = [GYTop2NewsModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.lunboImageFileUrl = loginModel.imageServiceUrl;
        for (GYTop2NewsModel *top2NewsModel in arr) {
            [self.lunboNewsArr addObject:top2NewsModel];
            [self.lunboTitleArr addObject:top2NewsModel.title];
            [self.lunboImageArr addObject:[NSString stringWithFormat:@"%@%@",self.lunboImageFileUrl,top2NewsModel.imageurl]];
        }
        if (self.lunboNewsArr.count > 0) {
            [self loadLunboViewWithTitleArr:self.lunboTitleArr AndImageArr:self.lunboImageArr];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadLunboViewWithTitleArr:(NSArray *)titleArr AndImageArr:(NSArray *)imageArr {
    //  混合图片
    NSArray *maxImageArray = imageArr;
    //  图片描述数组
    NSArray *describleArray = titleArr;
    self.carouselView = [CZZCarouselView carouselViewWithImageArray:maxImageArray describeArray:describleArray];
    //  设置frame
    self.carouselView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, _carouselViewHeight);
    //  用block处理图片点击
    __weak GYHomeVC *weakSelf = self;
    self.carouselView.imageClickBlock = ^(NSInteger index){
        NSLog(@"点击了第%ld张图片",index);
        if (weakSelf.lunboNewsArr.count > 0) {
            GYTop2NewsModel *top2NewsModel = weakSelf.lunboNewsArr[index];
            if (top2NewsModel.newstype == 1) {
                GYNewsRealDetailVC *newsRealDetailVC = [[GYNewsRealDetailVC alloc]init];
                newsRealDetailVC.newsDetail = top2NewsModel;
                newsRealDetailVC.myTitle = @"法院新闻";
                [weakSelf.navigationController pushViewController:newsRealDetailVC animated:YES];
            }
            if (top2NewsModel.newstype == 3) {
                GYNewsNoDetailVC *noDetailVC = [[GYNewsNoDetailVC alloc]init];
                noDetailVC.newsDetail = top2NewsModel;
                noDetailVC.myTitle = @"法院新闻";
                [weakSelf.navigationController pushViewController:noDetailVC animated:YES];
                
            }
        }
        
    };
    //  用代理处理点击图片事件，如果两个方法都实现，block优先级高于代理
    //    self.carouselView.delegate = self;
    //  设置每张图片的停留时间
    _carouselView.time = 2;
    //  设置分页控件的图片，不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    //  设置分页控制的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    /**
     *  设置图片描述控件
     */
    //  设置背景颜色，默认为黑色半透明
    _carouselView.desLabelBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //  设置字体，默认为13号字
    _carouselView.desLabelFont = [UIFont systemFontOfSize:14];
    //  设置文字颜色，默认为白色
    _carouselView.desLabelColor = [UIColor whiteColor];
    _carouselView.backgroundColor = [UIColor whiteColor];
    [self.homeDetailView addSubview:_carouselView];
}


#pragma mark - CZZCarouseViewDelagate  方法
-(void)carouselView:(CZZCarouselView *)carouselView didClickImage:(NSInteger)index
{
    NSLog(@"点击了第%ld张图片",index);
    
}

#pragma mark - scrollViewButtonDelegate  方法
- (void)btnClickWithBtnTag:(NSInteger)btnTag{
    
    
    switch (btnTag) {
        case 0:{
            self.courtView.hidden = NO;
            self.homeDetailView.hidden = YES;
            self.mxNavigationBar.hidden = YES;
            [self loadCourtData];
        }
            break;
        case 1:{
            GYLoginVC *loginVC = [[GYLoginVC alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            
            break;
        case 2:{
            GYSearchCaseLoginVC *searchLoginVC = [[GYSearchCaseLoginVC alloc]init];
            [self.navigationController pushViewController:searchLoginVC animated:YES];
        }
            
            break;
        case 3:{
            GYCourtDetailMainVC *CustomTabBar = [[GYCourtDetailMainVC alloc] init];
            [self.navigationController pushViewController:CustomTabBar animated:YES];
        }
            
            break;
        case 4:{
            GYPTMainVC *ptMainVC = [[GYPTMainVC alloc]init];
            [self.navigationController pushViewController:ptMainVC animated:YES];
        }
            
            break;
        case 5:{
            GYPeopleContactVC *peopleContactVC = [[GYPeopleContactVC alloc]init];
            [self.navigationController pushViewController:peopleContactVC animated:YES];
        }
            
            break;
        case 6:{
            GYNoticePublicVC *noticePVC = [[GYNoticePublicVC alloc]init];
            [self.navigationController pushViewController:noticePVC animated:YES];
        }
            
            break;
        case 7:{
            GYWssdLoginVC *wssdLoginVC = [[GYWssdLoginVC alloc]init];
            [self.navigationController pushViewController:wssdLoginVC animated:YES];
        }
            
            break;
        case 8:{
            GYReDocumentVC *ReDocumentVC = [[GYReDocumentVC alloc]init];
            [self.navigationController pushViewController:ReDocumentVC animated:YES];
        }
            
            break;
        case 9:{
            TopMenuSelectViewController *newsVC = [[TopMenuSelectViewController alloc]init];
            [self.navigationController pushViewController:newsVC animated:YES];
        }
            
            break;
        case 10:{
            [self callPhone];
        }
            
            break;
        
        case 11:{
            GYLiveBroadcastVC *LiveBroadcastVC = [[GYLiveBroadcastVC alloc]init];
            [self.navigationController pushViewController:LiveBroadcastVC animated:YES];
        }
            
            break;
        
        case 12:{
            GYGuideListVC *guideListVC = [[GYGuideListVC alloc]init];
            [self.navigationController pushViewController:guideListVC animated:YES];
        }
            break;
        case 13:{
            GYCourtNaviVC *courtNav = [[GYCourtNaviVC alloc]init];
            [self.navigationController pushViewController:courtNav animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)callPhone{
    NSString *message = @"确认拨打此电话？Tel:12368";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://12368"]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSArray *)dataArr{
    
    if (!_dataArr) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"funKeyboardData.plist" ofType:nil];
        _dataArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _dataArr;
}

-(CustomerScrollView *)btnScrollView{
    
    if (!_btnScrollView) {
        _btnScrollView = [[CustomerScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.lunboViewHeight)];
        _btnScrollView.delegate = self;
    }
    return _btnScrollView;
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (tableView == self.myTableView) {
        return self.top2NewsArr.count;
    } else if (tableView == self.courtTableView){
        return self.courtNameArr.count;
    }
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *tablecell = nil;
    if (tableView == self.myTableView) {
        GYHomeCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        if (!cell) {
            
            cell=[[GYHomeCell alloc]init];
            
        }
        cell.imageFileUrl = self.imageFileUrl;
        cell.newsModel = self.top2NewsArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tablecell = cell;
    } else if (tableView == self.courtTableView){
        GYCourtListCell *courtCell = [tableView dequeueReusableCellWithIdentifier:courtCellId];
        if (!courtCell) {
            
            courtCell=[[GYCourtListCell alloc]init];
            
        }
        courtCell.courtListModel = self.courtNameArr[indexPath.row];
        courtCell.setCourtBtn.tag = indexPath.row;
        courtCell.delegate = self;
        tablecell = courtCell;
    }
    
    return tablecell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (tableView == self.myTableView) {

        if([[UIScreen mainScreen] bounds].size.width == 768){
            return 110;
        }
        if([[UIScreen mainScreen] bounds].size.width == 1024){
            return 210;
        }
        return 88;
    } else if (tableView == self.courtTableView){
        return 50;
    }
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.myTableView) {
        if (self.top2NewsArr.count > 0) {
            GYTop2NewsModel *top2NewsModel = self.top2NewsArr[indexPath.row];
            if (top2NewsModel.newstype == 1) {
                GYNewsRealDetailVC *newsRealDetailVC = [[GYNewsRealDetailVC alloc]init];
                newsRealDetailVC.newsDetail = top2NewsModel;
                newsRealDetailVC.myTitle = @"法院新闻";
                [self.navigationController pushViewController:newsRealDetailVC animated:YES];
            }
            if (top2NewsModel.newstype == 3) {
                GYNewsNoDetailVC *noDetailVC = [[GYNewsNoDetailVC alloc]init];
                noDetailVC.newsDetail = top2NewsModel;
                noDetailVC.myTitle = @"法院新闻";
                [self.navigationController pushViewController:noDetailVC animated:YES];
            }
        }
    }else if (tableView == self.courtTableView){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (self.courtNameArr.count > 0) {
            GYCourtListModel *clickModel = self.courtNameArr[indexPath.row];
            if (clickModel.bmFy.count > 0) {
                [self.courtNameArr removeAllObjects];
            }
            NSArray *arr = [GYCourtListModel mj_objectArrayWithKeyValuesArray:clickModel.bmFy];
            for (GYCourtListModel *model in arr) {
                if ([clickModel.dm isEqualToString:model.sjdm]) {
                    [self.courtNameArr addObject:model];
                    [self.courtTableView reloadData];
                }
            }
        }
    }
}

- (void)loadCourtData {
    [self.courtNameArr removeAllObjects];
    [self.courtListArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = @"R00";
    [GYHttpTool post:courtUrl ticket:@"" params:params success:^(id json) {
        NSArray *arr = [GYCourtListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"fydm"]];
        for (GYCourtListModel *courtModel in arr) {
            if ([courtModel.xssx isEqualToString:@"R00"]) {
                [self.courtNameArr addObject:courtModel];
            }
            for (GYCourtListModel*model in courtModel.bmFy) {
                [self.courtListArr addObject:model];
            }
        }
        [self.courtTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)ChooseCourtWithBtnTag:(NSInteger)index{
    GYCourtListModel *courtListModel = self.courtNameArr[index];
    self.courtView.hidden = YES;
    self.homeDetailView.hidden = NO;
    self.mxNavigationBar.hidden = NO;
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    if ([courtDm isEqualToString:courtListModel.dm]) {
        return;
    }
    if (self.courtNameArr.count > 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:courtListModel.dm forKey:@"chooseCourt_dm"];
        [[NSUserDefaults standardUserDefaults] setObject:courtListModel.dmms forKey:@"chooseCourt_name"];
        [[NSUserDefaults standardUserDefaults] setObject:courtListModel.fyjc forKey:@"chooseCourt_fyjc"];
        self.mxNavigationItem.title = [NSString stringWithFormat:@"%@法院自助服务",courtListModel.fyjc];
        [self loadLunBoNewsInfo];
        [self loadTop2NewsInfo];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"R00" forKey:@"chooseCourt_dm"];
    }
    
    
}

- (IBAction)courtViewBack:(id)sender {
    self.courtView.hidden = YES;
    self.homeDetailView.hidden = NO;
    self.mxNavigationBar.hidden = NO;
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

- (NSMutableArray *)top2NewsArr {
	if(_top2NewsArr == nil) {
		_top2NewsArr = [[NSMutableArray alloc] init];
	}
	return _top2NewsArr;
}

- (NSMutableArray *)lunboNewsArr {
	if(_lunboNewsArr == nil) {
		_lunboNewsArr = [[NSMutableArray alloc] init];
	}
	return _lunboNewsArr;
}

- (NSMutableArray *)lunboTitleArr {
	if(_lunboTitleArr == nil) {
		_lunboTitleArr = [[NSMutableArray alloc] init];
	}
	return _lunboTitleArr;
}

- (NSMutableArray *)lunboImageArr {
	if(_lunboImageArr == nil) {
		_lunboImageArr = [[NSMutableArray alloc] init];
	}
	return _lunboImageArr;
}

- (NSMutableArray *)ktggNameList {
	if(_ktggNameList == nil) {
		_ktggNameList = [[NSMutableArray alloc] init];
	}
	return _ktggNameList;
}

@end
