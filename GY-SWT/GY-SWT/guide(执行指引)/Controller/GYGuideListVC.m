//
//  GYGuideListVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/25.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYGuideListVC.h"
#import "MXConstant.h"
#import "GYGuideListCell.h"
#import "GYGuideListModel.h"
#import "GYGuideWebVC.h"

static NSString *ID=@"GYGuideListCell";



@interface GYGuideListVC ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (nonatomic, strong) NSMutableArray *guideListArr;
@end

@implementation GYGuideListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadGuideListData];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-执行指引",fyjc];
    self.detailView.layer.cornerRadius = 5;
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYGuideListCell" bundle:nil] forCellReuseIdentifier:ID];
}

- (void)loadGuideListData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = @"R00";
    params[@"pageSize"] = @"100";
    params[@"page"] = @"1";
    [GYHttpTool post:zxzy_listInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"guide:%@",json);
        NSArray *arr = [GYGuideListModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYGuideListModel *model in arr) {
            [self.guideListArr addObject:model];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.guideListArr.count;
    
}


- (GYGuideListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYGuideListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYGuideListCell alloc]init];
        
    }
    cell.guideListModel = self.guideListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 50;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYGuideListModel *model = self.guideListArr[indexPath.row];
    
    GYGuideWebVC *guideWebVC = [[GYGuideWebVC alloc]init];
    guideWebVC.guideModel = model;
    [self.navigationController pushViewController:guideWebVC animated:YES];
}



- (NSMutableArray *)guideListArr {
	if(_guideListArr == nil) {
		_guideListArr = [[NSMutableArray alloc] init];
	}
	return _guideListArr;
}

@end
