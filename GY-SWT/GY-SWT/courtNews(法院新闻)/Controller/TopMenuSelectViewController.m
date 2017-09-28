//
//  TopMenuSelectViewController.m
//  TopMenuSelect
//
//  Created by ecar on 16/3/15.
//  Copyright © 2016年 zhangqian. All rights reserved.
//

#import "TopMenuSelectViewController.h"
#import "MXConstant.h"
#import "GYNewsTypeListModel.h"
#import "GYTop2NewsModel.h"
#import "GYNewsInfoListCell.h"
#import "GYNewsRealDetailVC.h"
#import "GYNewsNoDetailVC.h"

static NSString *ID=@"GYNewsInfoListCell";



#define MENU_BUTTON_WIDTH  80
#define ViewWidth [[UIScreen mainScreen] bounds].size.width
#define ViewHeight [[UIScreen mainScreen] bounds].size.height

@interface TopMenuSelectViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *newsTitleArr;
@property (nonatomic, strong) NSMutableArray *newsTypeIdArr;
@property (nonatomic, strong) NSMutableArray *newsListInfoArr;
@property (nonatomic, copy) NSString *imageFileUrl;

@property (nonatomic, copy) NSString *checkScrollStr;

@end

@implementation TopMenuSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.title = @"顶部标签菜单";
    
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    [self loadNewsTypeListInfo];
    
}


- (void)loadNewsTypeListInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    params[@"fydm"] = courtDm;
    [GYHttpTool post:news_typeListUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"news==%@",json);
        NSArray *arr = [GYNewsTypeListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNewsTypeListModel *newsTypeModel in arr) {
            NSLog(@"%@",newsTypeModel.name);
            [self.newsTitleArr addObject:newsTypeModel.name];
            [self.newsTypeIdArr addObject:newsTypeModel];
        }
        _tableViewArray = [[NSMutableArray alloc]init];
        [self createMenuWithTitleArr:self.newsTitleArr];
        [self refreshTableView:0];
        [self loadNewsListByTypeId:@"１"];
        self.checkScrollStr = @"１";
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadNewsListByTypeId:(NSString *)typeId {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    [self.newsListInfoArr removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"newsTypeId"] = typeId;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    params[@"fydm"] = courtDm;
    [GYHttpTool post:news_ListByTypeIdUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYTop2NewsModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYTop2NewsModel *newsInfoModel in arr) {
            [self.newsListInfoArr addObject:newsInfoModel];
        }
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        self.imageFileUrl = loginModel.imageServiceUrl;
        [MBProgressHUD hideHUDForView:self.view];
        [self.refreshTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)createMenuWithTitleArr:(NSArray *)titleArr {
    _menuArray = titleArr;
    for (int i = 0; i < _menuArray.count; i ++) {
        UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
        [menu setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, _menuScrollView.frame.size.height)];
        [menu setTitle:_menuArray[i] forState:UIControlStateNormal];
        [menu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        menu.titleLabel.font = [UIFont systemFontOfSize:14.0];
        menu.tag = i;
        [menu addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [_menuScrollView addSubview:menu];
    }
    [_menuScrollView setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * _menuArray.count, _menuScrollView.frame.size.height)];
    _menuBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _menuScrollView.frame.size.height - 2, MENU_BUTTON_WIDTH, 2)];
    [_menuBgView setBackgroundColor:newsSelectBackColor];
    [_menuScrollView addSubview:_menuBgView];
    _scrollView.contentSize = CGSizeMake(ViewWidth * _menuArray.count, _scrollView.frame.size.height);
    [self addTableViewToScrollView:_scrollView count:_menuArray.count frame:CGRectZero];
}

- (void)selectMenu:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    [_scrollView setContentOffset:CGPointMake(ViewWidth * sender.tag, 0) animated:YES];
    float xx = ViewWidth * (sender.tag - 1) * (MENU_BUTTON_WIDTH / ViewWidth) - MENU_BUTTON_WIDTH;
    [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, ViewWidth, _menuScrollView.frame.size.height) animated:YES];
    GYNewsTypeListModel *typeListModel = self.newsTypeIdArr[sender.tag];
    if (![self.checkScrollStr isEqualToString:typeListModel.id]) {
        [self loadNewsListByTypeId:typeListModel.id];
        self.checkScrollStr = typeListModel.id;
    }
    [self refreshTableView:(int)sender.tag];
}

- (void)addTableViewToScrollView:(UIScrollView *)scrollView count:(NSUInteger)pageCount frame:(CGRect)frame {
    for (int i = 0; i < pageCount; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(ViewWidth * i, 0 , ViewWidth, ViewHeight - _menuScrollView.frame.size.height - 64)];
        [tableView registerNib:[UINib nibWithNibName:@"GYNewsInfoListCell" bundle:nil] forCellReuseIdentifier:ID];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        tableView.backgroundColor = [UIColor clearColor];
        [_tableViewArray addObject:tableView];
        [scrollView addSubview:tableView];
    }
}

- (void)refreshTableView:(int)index {
    _refreshTableView = _tableViewArray[index];
    CGRect frame = _refreshTableView.frame;
    frame.origin.x = ViewWidth * index;
    [_refreshTableView setFrame:frame];
    _menuTittle = _menuArray[index];
    self.mxNavigationItem.title = _menuTittle;
//    [_refreshTableView reloadData];
}

- (void)changeView:(float)x {
    float xx = x * (MENU_BUTTON_WIDTH / ViewWidth);
    [_menuBgView setFrame:CGRectMake(xx, _menuBgView.frame.origin.y, _menuBgView.frame.size.width, _menuBgView.frame.size.height)];
}

#pragma mark - UITableViewDataSource和UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListInfoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (GYNewsInfoListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNewsInfoListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNewsInfoListCell alloc]init];
        
    }
    cell.imageFileUrl = self.imageFileUrl;
    cell.newsInfoListModel = self.newsListInfoArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYTop2NewsModel *infolistModel = self.newsListInfoArr[indexPath.row];
    if (infolistModel.newstype == 1) {
        GYNewsRealDetailVC *newsRealDetailVC = [[GYNewsRealDetailVC alloc]init];
        newsRealDetailVC.newsDetail = infolistModel;
        newsRealDetailVC.myTitle = self.mxNavigationItem.title;
        [self.navigationController pushViewController:newsRealDetailVC animated:YES];
    }
    if (infolistModel.newstype == 3) {
        GYNewsNoDetailVC *noDetailVC = [[GYNewsNoDetailVC alloc]init];
        noDetailVC.newsDetail = infolistModel;
        noDetailVC.myTitle = self.mxNavigationItem.title;
        [self.navigationController pushViewController:noDetailVC animated:YES];

    }
    
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //只要滚动了就会触发
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }
    else
    {
        [self changeView:scrollView.contentOffset.x];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //减速停止了时执行，手触摸时执行执行
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }
    else
    {
        float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / ViewWidth) - MENU_BUTTON_WIDTH;
        [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, ViewWidth, _menuScrollView.frame.size.height) animated:YES];
        int i = (scrollView.contentOffset.x / ViewWidth);
        GYNewsTypeListModel *typeListModel = self.newsTypeIdArr[i];
        if (![self.checkScrollStr isEqualToString:typeListModel.id]) {
            [self loadNewsListByTypeId:typeListModel.id];
            self.checkScrollStr = typeListModel.id;
        }
        [self refreshTableView:i];
        NSLog(@"i==%d",i);
        
    }
}



- (NSMutableArray *)newsTitleArr {
	if(_newsTitleArr == nil) {
		_newsTitleArr = [[NSMutableArray alloc] init];
	}
	return _newsTitleArr;
}

- (NSMutableArray *)newsTypeIdArr {
	if(_newsTypeIdArr == nil) {
		_newsTypeIdArr = [[NSMutableArray alloc] init];
	}
	return _newsTypeIdArr;
}

- (NSMutableArray *)newsListInfoArr {
	if(_newsListInfoArr == nil) {
		_newsListInfoArr = [[NSMutableArray alloc] init];
	}
	return _newsListInfoArr;
}

@end
