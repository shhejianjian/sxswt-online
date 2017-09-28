//
//  GYSCDetailThirdVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCDetailThirdVC.h"
#import "MXConstant.h"
#import "GYSpDsrXxCell.h"
#import "GYSPDsrModel.h"
#import "GYSPSpzzModel.h"
#import "GYSCSpDetailModel.h"

extern NSString *cbbmStr;

static NSString *ID=@"GYSpDsrXxCell";


@interface GYSCDetailThirdVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *mytableView;

@property (nonatomic, strong) NSMutableArray *spzzListArr;

@end

@implementation GYSCDetailThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    [self.mytableView registerNib:[UINib nibWithNibName:@"GYSpDsrXxCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loaddetailData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated{
    cbbmStr = nil;
}

- (void)loaddetailData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"==%@--%@",json,params);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [GYSPSpzzModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"spzzList"]];
        for (GYSPSpzzModel *dsrModel in arr) {
            [self.spzzListArr addObject:dsrModel];
        }
        [self.mytableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.spzzListArr.count;
    
}


- (GYSpDsrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYSpDsrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYSpDsrXxCell alloc]init];
        
    }
    cell.cbbmString = cbbmStr;
    cell.spDlrModel = self.spzzListArr[indexPath.row];
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



- (NSMutableArray *)spzzListArr {
	if(_spzzListArr == nil) {
		_spzzListArr = [[NSMutableArray alloc] init];
	}
	return _spzzListArr;
}

@end
