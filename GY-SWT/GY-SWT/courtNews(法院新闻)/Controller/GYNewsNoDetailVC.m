//
//  GYNewsNoDetailVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNewsNoDetailVC.h"
#import "MXConstant.h"
#import "GYImageNewsModel.h"
#import "GYImageNewsCell.h"

static NSString *ID=@"GYImageNewsCell";



@interface GYNewsNoDetailVC ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *imageNewsArr;

@end

@implementation GYNewsNoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = self.myTitle;
    [self setUI];
}

- (void) setUI {
    self.titleLabel.text = self.newsDetail.title;
    self.dateLabel.text = [NSString stringWithFormat:@"发布日期:%@",self.newsDetail.pubdate];
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYImageNewsCell" bundle:nil] forCellReuseIdentifier:ID];
    [self loadNewsDetailData];
}

- (void)loadNewsDetailData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"newsId"] = self.newsDetail.id;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    
    [GYHttpTool post:news_detailUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"loadNewsDetailData:%@",json);
        NSArray *arr = [GYImageNewsModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYImageNewsModel *newsInfoModel in arr) {
            [self.imageNewsArr addObject:newsInfoModel];
        }
        [self.myTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.imageNewsArr.count;
    
}


- (GYImageNewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYImageNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYImageNewsCell alloc]init];
        
    }
    cell.imageNewsModel = self.imageNewsArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return (3*(KScreenW-10-10)/4.5);
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}




- (NSMutableArray *)imageNewsArr {
	if(_imageNewsArr == nil) {
		_imageNewsArr = [[NSMutableArray alloc] init];
	}
	return _imageNewsArr;
}

@end
