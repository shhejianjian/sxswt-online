//
//  GYNRDetailThirdVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailThirdVC.h"
#import "MXConstant.h"
#import "GYNRDlrXxCell.h"
#import "GYNRDlrXxModel.h"

static NSString *ID=@"GYNRDlrXxCell";

@interface GYNRDetailThirdVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dlrXxListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation GYNRDetailThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    [self loadWslaAjxxDetailInfo];
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRDlrXxCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)loadWslaAjxxDetailInfo{
    [self.dlrXxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"wsla_ajxx_ajbs"];
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
        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];
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
    
    return 120;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}



- (NSMutableArray *)dlrXxListArr {
    if(_dlrXxListArr == nil) {
        _dlrXxListArr = [[NSMutableArray alloc] init];
    }
    return _dlrXxListArr;
}

@end
