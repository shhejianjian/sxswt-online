//
//  GYTourVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/28.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYTourVC.h"
#import "MXConstant.h"
#import "GYCourtNavCell.h"
#import "GYCourtDetailMainVC.h"
#import "GYNavWebView.h"
static NSString *ID=@"GYCourtNavCell";



@interface GYTourVC ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation GYTourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"我是游客";
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYCourtNavCell" bundle:nil] forCellReuseIdentifier:ID];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 4;
    
}


- (GYCourtNavCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYCourtNavCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYCourtNavCell alloc]init];
        
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"ssfwzx"];
        cell.titleLabel.text = @"了解法院";
    } else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"cxflzs"];
        cell.titleLabel.text = @"查询法律知识";
    } else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"ywlc"];
        cell.titleLabel.text = @"法院业务流程";
    } else if (indexPath.row == 3){
        cell.imageView.image = [UIImage imageNamed:@"zxzx"];
        cell.titleLabel.text = @"在线咨询";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 60;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        GYCourtDetailMainVC *CustomTabBar = [[GYCourtDetailMainVC alloc] init];
        [self.navigationController pushViewController:CustomTabBar animated:YES];
    } else if (indexPath.row == 1){
        GYNavWebView *navWebVC = [[GYNavWebView alloc]init];
        navWebVC.webUrl = @"http://www.npc.gov.cn/npc/xinwen/node_12488.htm";
        navWebVC.myTitle = @"查询法律知识";
        [self.navigationController pushViewController:navWebVC animated:YES];
    } else if (indexPath.row == 2){
        GYNavWebView *navWebVC = [[GYNavWebView alloc]init];
        navWebVC.webUrl = @"http://www.sxgaofa.cn/swgk/view?id=5";
        navWebVC.myTitle = @"法院业务流程";
        [self.navigationController pushViewController:navWebVC animated:YES];
    } else if (indexPath.row == 3){
        [self callPhone];
    }
}
- (void)callPhone{
    NSString *message = @"确认拨打此电话？Tel:12368";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://12368"]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
