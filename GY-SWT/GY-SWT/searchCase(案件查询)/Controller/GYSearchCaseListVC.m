//
//  GYSearchCaseListVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSearchCaseListVC.h"
#import "MXConstant.h"
#import "GYNoticePucCell.h"
#import "GYSCListModel.h"
#import "GYSCTabbarVC.h"
#import "GYSCZXTabbarVC.h"
static NSString *ID=@"GYNoticePucCell";



@interface GYSearchCaseListVC ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (nonatomic, strong) NSMutableArray *scListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation GYSearchCaseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-案件信息查询",fyjc];
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"GYNoticePucCell" bundle:nil] forCellReuseIdentifier:ID];
    
    
    [self loadListData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadListData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:ajxcListUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [GYSCListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYSCListModel *sclistModel in arr) {
            [self.scListArr addObject:sclistModel];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.scListArr.count;
    
}


- (GYNoticePucCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNoticePucCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNoticePucCell alloc]init];
        
    }
    cell.scListModel = self.scListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 70;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GYSCListModel *scListModel = self.scListArr[indexPath.row];
    NSLog(@"==%ld",(long)scListModel.ajlb);
    [[NSUserDefaults standardUserDefaults] setObject:scListModel.ajbs forKey:@"ajxxcx_ajbs"];
    
//    if ([self.ajTypeStr isEqualToString:@"2"]) {
//        GYSCTabbarVC *scTabbarVC = [[GYSCTabbarVC alloc]init];
//        scTabbarVC.ahqcStr = scListModel.ahqc;
//        [self.navigationController pushViewController:scTabbarVC animated:YES];
//    }
    if (scListModel.ajlb == 8) {
        GYSCZXTabbarVC *zxTabbarVC = [[GYSCZXTabbarVC alloc]init];
        zxTabbarVC.ahqcStr = scListModel.ahqc;
        [self.navigationController pushViewController:zxTabbarVC animated:YES];
    } else {
        GYSCTabbarVC *scTabbarVC = [[GYSCTabbarVC alloc]init];
        scTabbarVC.ahqcStr = scListModel.ahqc;
        [self.navigationController pushViewController:scTabbarVC animated:YES];
    }
}

- (NSMutableArray *)scListArr {
    if(_scListArr == nil) {
        _scListArr = [[NSMutableArray alloc] init];
    }
    return _scListArr;
}



@end
