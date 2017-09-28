//
//  GYNRDetailSecondVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailSecondVC.h"
#import "GYNRSegmentView.h"
#import "MXConstant.h"
#import "GYNRDsrXxCell.h"
#import "GYNRDsrXxModel.h"


static NSString *ID=@"GYNRDsrXxCell";



@interface GYNRDetailSecondVC ()<GYNRSegmentViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, copy) NSString *ssdwType;

@property (nonatomic, strong) NSMutableArray *dsrXxListArr;



/** 记录当前页码 */
@property (nonatomic, assign) int currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger  totalCount;

@end

@implementation GYNRDetailSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    GYNRSegmentView *segView=[[GYNRSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    segView.delegate = self;
    segView.titles = @[@"原告信息",@"被告信息"];
    segView.titleFont = Font(15);
    [self.view addSubview:segView];

    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    
     [self.myTableView registerNib:[UINib nibWithNibName:@"GYNRDsrXxCell" bundle:nil] forCellReuseIdentifier:ID];
    
    [self loadWslaAjxxDetailInfoWithSsdw:@"原告"];
    // Do any additional setup after loading the view from its nib.
}
- (void)loadWslaAjxxDetailInfoWithSsdw:(NSString *)ssdwName{
    [self.dsrXxListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"wsla_ajxx_ajbs"];
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_detailDsrInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYNRDsrXxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYNRDsrXxModel *dsrModel in arr) {
            NSLog(@"+++%@",dsrModel.ssdwmc);
            
            if ([dsrModel.ssdwmc isEqualToString:ssdwName]) {
                [self.dsrXxListArr addObject:dsrModel];
                
            }
        }
        
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];
    }];
}
- (IBAction)btnCLick:(id)sender {
    
    
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.dsrXxListArr.count;
    
}


- (GYNRDsrXxCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYNRDsrXxCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYNRDsrXxCell alloc]init];
        
    }
    cell.gynrDsrxxModel = self.dsrXxListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 110;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}








- (NSMutableArray *)dsrXxListArr {
    if(_dsrXxListArr == nil) {
        _dsrXxListArr = [[NSMutableArray alloc] init];
    }
    return _dsrXxListArr;
}


-(void)segmentView:(GYNRSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
            if (![self.ssdwType isEqualToString:@"原告"]) {
                [self loadWslaAjxxDetailInfoWithSsdw:@"原告"];
                self.ssdwType = @"原告";
            }
            
            break;
        case 1:
            if (![self.ssdwType isEqualToString:@"被告"]) {
                [self loadWslaAjxxDetailInfoWithSsdw:@"被告"];
                self.ssdwType = @"被告";
            }
            break;
        default:
            break;
    }
}


@end
