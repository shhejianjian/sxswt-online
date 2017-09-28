//
//  GYSCDetailSecondVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCDetailSecondVC.h"
#import "GYSPDsrModel.h"
#import "GYSpDsrXxCell.h"
#import "MXConstant.h"

static NSString *ID=@"GYSpDsrXxCell";

@interface GYSCDetailSecondVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *spDsrListArr;
/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;
@end

@implementation GYSCDetailSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYSpDsrXxCell" bundle:nil] forCellReuseIdentifier:ID];

    [self loaddetailData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loaddetailData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"==%@--%@",json,params);
        [MBProgressHUD hideHUDForView:self.view];
//        GYSPDsrModel *spDsrModel = [GYSPDsrModel mj_objectWithKeyValues:json[@"parameters"][@"cyrxxList"]];
        NSArray *arr = [GYSPDsrModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"cyrxxList"]];
        for (GYSPDsrModel *dsrModel in arr) {
            [self.spDsrListArr addObject:dsrModel];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.spDsrListArr.count;
    
}


- (GYSpDsrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYSpDsrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYSpDsrXxCell alloc]init];
        
    }
    cell.spDsrModel = self.spDsrListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 105;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





- (NSMutableArray *)spDsrListArr {
    if(_spDsrListArr == nil) {
        _spDsrListArr = [[NSMutableArray alloc] init];
    }
    return _spDsrListArr;
}
@end
