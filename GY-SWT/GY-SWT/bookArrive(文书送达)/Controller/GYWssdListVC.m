//
//  GYWssdListVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/3/2.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYWssdListVC.h"
#import "MXConstant.h"
#import "GYNRSegmentView.h"
#import "GYWssdModel.h"
#import "GYWssdListCell.h"
#import "GYWssdDetailWebView.h"
static NSString *ID=@"GYWssdListCell";



@interface GYWssdListVC () <GYNRSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *wssdListArr;
@property (nonatomic, copy) NSString *filePath;
@end

@implementation GYWssdListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-文书送达",fyjc];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    GYNRSegmentView *segView=[[GYNRSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    segView.delegate = self;
    segView.titles = @[@"待办文书",@"已办文书"];
    segView.titleFont = Font(15);
    [self.view addSubview:segView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYWssdListCell" bundle:nil] forCellReuseIdentifier:ID];
    
    [self loadWssdDetailListInfoWithSdzt:@"1"];
}

- (void)loadWssdDetailListInfoWithSdzt:(NSString *)sdzt{
    [self.wssdListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"sdzt"] = sdzt;
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"wssd_loginTicket"];
    [GYHttpTool post:wssd_listInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@---",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            if ([loginModel.msg isEqualToString:@"当前没有信息"]) {
                [MBProgressHUD showError:loginModel.msg];
            }
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
        NSArray *arr = [GYWssdModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYWssdModel *wssdModel in arr) {
            [self.wssdListArr addObject:wssdModel];
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
    
    return self.wssdListArr.count;
    
}


- (GYWssdListCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYWssdListCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYWssdListCell alloc]init];
        
    }
    cell.wssdModel = self.wssdListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 100;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYWssdModel *wssdModel = self.wssdListArr[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"需输入正确的密钥才可查看哦" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alertController.textFields[0].text.length == 0) {
            [MBProgressHUD showError:@"密钥不得为空"];
            return ;
        }
        [MBProgressHUD showMessage:@"正在加载" toView:self.view];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = wssdModel.ywId;
        params[@"password"] = alertController.textFields[0].text;
        NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"wssd_loginTicket"];
        
        [GYHttpTool postImage:wssd_detailInfoUrl ticket:ticket params:params success:^(id json) {
            NSLog(@"json:::==%@==%@",json,params);
            if (json) {
                [MBProgressHUD hideHUDForView:self.view];
                NSString *rootPath = [self dirDoc];
                _filePath= [rootPath  stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",alertController.textFields[0].text]];
                [json writeToFile:_filePath atomically:NO];
                NSLog(@"filePath:%@",_filePath);
                GYWssdDetailWebView *wssdDetialVC = [[GYWssdDetailWebView alloc]init];
                wssdDetialVC.pdfFilePath = _filePath;
                [self.navigationController pushViewController:wssdDetialVC animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        textField.placeholder = @"请输入密钥";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

//获取Documents目录
-(NSString *)dirDoc{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


-(void)segmentView:(GYNRSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
            [self loadWssdDetailListInfoWithSdzt:@"2"];
            
            break;
        case 1:
            [self loadWssdDetailListInfoWithSdzt:@"1"];
            break;
        default:
            break;
    }
}

- (NSMutableArray *)wssdListArr {
	if(_wssdListArr == nil) {
		_wssdListArr = [[NSMutableArray alloc] init];
	}
	return _wssdListArr;
}

@end
