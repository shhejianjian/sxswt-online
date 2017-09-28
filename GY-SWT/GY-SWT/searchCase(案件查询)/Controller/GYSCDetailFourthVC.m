//
//  GYSCDetailFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCDetailFourthVC.h"
#import "MXConstant.h"
#import "XFSegmentView.h"
#import "GYSpFourthCell.h"
#import "GYSpSXxxModel.h"
#import "GYSpSxbgModel.h"
#import "GYSpCxbgModel.h"
static NSString *ID=@"GYSpFourthCell";


@interface GYSCDetailFourthVC ()<XFSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *tsxxListArr;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *clickType;
@end

@implementation GYSCDetailFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"庭审信息",@"审限变更",@"程序变更"];
    segView.titleFont = Font(15);
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYSpFourthCell" bundle:nil] forCellReuseIdentifier:ID];

    [self loadTsxxData];
    self.index = 0;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadTsxxData {
    self.clickType = @"1";
    [self.tsxxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"==%@--%@",json,params);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [GYSpSXxxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"ftsyList"]];
        for (GYSpSXxxModel *tsxxModel in arr) {
            
            [self.tsxxListArr addObject:tsxxModel];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadSxbgData {
    self.clickType = @"2";
    [self.tsxxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"==%@--%@",json,params);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [GYSpSxbgModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"sxbgList"]];
        for (GYSpSxbgModel *sxbgModel in arr) {
            
            [self.tsxxListArr addObject:sxbgModel];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadCxbgData {
    self.clickType = @"3";
    [self.tsxxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajxxcx_ajbs"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"ajcx_loginTicket"];
    [GYHttpTool post:spajcxDetailUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"==%@--%@",json,params);
        [MBProgressHUD hideHUDForView:self.view];
        NSArray *arr = [GYSpCxbgModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"cxbgList"]];
        for (GYSpCxbgModel *cxbgModel in arr) {
            
            [self.tsxxListArr addObject:cxbgModel];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    self.index = index;
    switch (index) {
            case 0:
            if (![self.clickType isEqualToString:@"1"]) {
                self.clickType = @"1";
                [self loadTsxxData];
            }
            
            break;
            
            case 1:
            if (![self.clickType isEqualToString:@"2"]) {
                self.clickType = @"2";
                [self loadSxbgData];
            }
            
            break;
            
            case 2:
            if (![self.clickType isEqualToString:@"3"]) {
                self.clickType = @"3";
                [self loadCxbgData];
            }
            break;
        default:
            break;
    }
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.tsxxListArr.count;
    
}


- (GYSpFourthCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYSpFourthCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYSpFourthCell alloc]init];
        
    }
//    cell.cbbmString = cbbmStr;
    if (self.index == 0) {
        cell.firstLabel.text = @"开始时间:";
        cell.secondLabel.text = @"结束时间:";
        cell.thirdLabel.text = @"开庭地点:";
        cell.thirdLabel.hidden = NO;
        cell.ktddLabel.hidden = NO;
        cell.tsxxModel = self.tsxxListArr[indexPath.row];
    } else if (self.index == 1) {
        cell.firstLabel.text = @"开始日期:";
        cell.secondLabel.text = @"结束日期:";
        cell.thirdLabel.text = @"变更名称:";
        cell.thirdLabel.hidden = NO;
        cell.ktddLabel.hidden = NO;
        cell.sxbgModel = self.tsxxListArr[indexPath.row];
    } else if (self.index == 2) {
        cell.firstLabel.text = @"变更日期:";
        cell.secondLabel.text = @"变更名称:";
        cell.thirdLabel.hidden = YES;
        cell.ktddLabel.hidden = YES;
        cell.cxbgModel = self.tsxxListArr[indexPath.row];
    }
    
    
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (self.index == 2){
        return 80;
    } else {
        return 105;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





- (NSMutableArray *)tsxxListArr {
	if(_tsxxListArr == nil) {
		_tsxxListArr = [[NSMutableArray alloc] init];
	}
	return _tsxxListArr;
}

@end
