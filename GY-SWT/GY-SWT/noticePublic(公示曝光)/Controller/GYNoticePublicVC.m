//
//  GYNoticePublicVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNoticePublicVC.h"
#import "MXConstant.h"
#import "XFSegmentView.h"
#import "LGLSearchBar.h"
#import "GYNoticePucCell.h"
#import "GYNPModel.h"
#import "GYNPDetailModel.h"

static NSString *ID=@"GYNoticePucCell";



#define SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GYNoticePublicVC ()<XFSegmentViewDelegate>
//{
//    UIImageView *imgView;
//    NSArray *names;
//}
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *cellDetailView;
@property (strong, nonatomic) IBOutlet UIButton *backToTableBtn;

@property (nonatomic, strong) NSString *searchType;
@property (nonatomic, strong) NSMutableArray *losePeopleListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;


//detailView信息
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *fymcLabel;
@property (strong, nonatomic) IBOutlet UILabel *larqLabel;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic) IBOutlet UILabel *mzLabel;
@property (strong, nonatomic) IBOutlet UILabel *sfzhLabel;
@property (strong, nonatomic) IBOutlet UILabel *dwmcLabel;
@property (strong, nonatomic) IBOutlet UILabel *xzfsLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation GYNoticePublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-失信人员名单",fyjc];
    self.detailView.layer.cornerRadius = 5;
    self.cellDetailView.layer.cornerRadius = 5;
    self.myTableView.layer.cornerRadius = 5;
    self.backToTableBtn.layer.cornerRadius = 15;
    
//    names = @[@"1",@"2",@"3"];
//    self.view.backgroundColor=ContentBackGroundColor;
    
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, 40)];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"限制高消费",@"限制出境",@"失信人员"];
    segView.titleFont = Font(15);
    
    LGLSearchBar * searchBar = [[LGLSearchBar alloc] initWithFrame:CGRectMake(15, 114, SCREENWIDTH - 30, 40) searchBarStyle:LGLSearchBarStyleDefault];
//    searchBar.barBackgroudColor = MainRedColor;
//    searchBar.textBackgroudColor = [UIColor greenColor];
    searchBar.barBackgroudColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
//    searchBar.textBackgroudColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
    searchBar.layer.cornerRadius = 5;
    searchBar.layer.masksToBounds = YES;
    self.searchType = @"2";
    [searchBar searchBarTextSearchTextBlock:^(NSString *searchText) {
        [self.losePeopleListArr removeAllObjects];
        [self loadLosePeopleDataWithType:self.searchType AndName:searchText];
    }];
    [self.view addSubview:searchBar];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    [self.myTableView.mj_header beginRefreshing];
    
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"GYNoticePucCell" bundle:nil] forCellReuseIdentifier:ID];
    
//    [self loadLosePeopleDataWithType:@"2" AndName:@""];
    // Do any additional setup after loading the view from its nib.
}


- (void)loadNewData
{
    [self.losePeopleListArr removeAllObjects];
    self.currentPage = 1;
    [self loadLosePeopleDataWithType:self.searchType AndName:@""];
}
- (void)loadMoreData
{
    self.currentPage ++;
    [self loadLosePeopleDataWithType:self.searchType AndName:@""];
}
- (void)loadLosePeopleDataWithType:(NSString *)type AndName:(NSString *)name{
//    [self.losePeopleListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @"8";
    params[@"page"] = @(self.currentPage);
    params[@"lx"] = type;
    params[@"xm"] = name;
    [GYHttpTool post:noticePublic ticket:@"" params:params success:^(id json) {
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.totalCount = [loginModel.count integerValue];
        NSLog(@"%@",json);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [GYNPModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNPModel *losePeopleModel in arr) {
            [self.losePeopleListArr addObject:losePeopleModel];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.losePeopleListArr.count == self.totalCount) {
        self.myTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.myTableView.mj_footer.state = MJRefreshStateIdle;
    }
    return self.losePeopleListArr.count;
    
}


- (GYNoticePucCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GYNoticePucCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNoticePucCell alloc]init];
        
    }
    if (self.losePeopleListArr.count !=0) {
        cell.losePeopleModel = self.losePeopleListArr[indexPath.row];
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myTableView.hidden = YES;
    self.cellDetailView.hidden = NO;
    
    
    GYNPModel *losePeopleModel = self.losePeopleListArr[indexPath.row];
    NSLog(@"%@----",losePeopleModel.id);
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = losePeopleModel.id;
    [GYHttpTool post:npDetailUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        GYNPDetailModel *detailModel = [GYNPDetailModel mj_objectWithKeyValues:json[@"parameters"][@"gsbgxx"]];
        
        self.ahqcLabel.text = detailModel.ahqc;
        self.fymcLabel.text = detailModel.fymc;
        self.larqLabel.text = detailModel.cjsj;
        self.sexLabel.text = detailModel.xbmc;
        self.mzLabel.text = detailModel.mzmc;
        self.sfzhLabel.text = detailModel.sfzjhm;
        self.dwmcLabel.text = detailModel.dwmc;
        self.xzfsLabel.text = detailModel.lxmc;
        self.nameLabel.text = detailModel.xm;
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
- (IBAction)backToTableClick:(id)sender {
    self.cellDetailView.hidden = YES;
    self.myTableView.hidden = NO;
}


-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    
        switch (index) {
            case 0:
                if (![self.searchType isEqualToString:@"2"]) {
                    
                    self.searchType = @"2";
                    [self loadNewData];
                }                 break;
            case 1:
                if (![self.searchType isEqualToString:@"1"]) {
                    
                    self.searchType = @"1";
                    [self loadNewData];
                }
                break;
            case 2:
                if (![self.searchType isEqualToString:@"3"]) {

                    self.searchType = @"3";
                    [self loadNewData];
                }
                break;
                    
            default:
                break;
        }
    self.myTableView.hidden = NO;
    self.cellDetailView.hidden = YES;

}


- (NSMutableArray *)losePeopleListArr {
    if(_losePeopleListArr == nil) {
        _losePeopleListArr = [[NSMutableArray alloc] init];
    }
    return _losePeopleListArr;
}

@end
