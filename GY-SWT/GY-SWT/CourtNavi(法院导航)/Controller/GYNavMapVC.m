//
//  GYNavMapVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/28.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNavMapVC.h"
#import "MXConstant.h"
#import "GYCourtNavCell.h"
#import "GYNavWebView.h"
#import "GYGuideListVC.h"

static NSString *ID=@"GYCourtNavCell";

@interface GYNavMapVC ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation GYNavMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"导航地图";
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYCourtNavCell" bundle:nil] forCellReuseIdentifier:ID];

}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 5;
    
}


- (GYCourtNavCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYCourtNavCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYCourtNavCell alloc]init];
        
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"jlzx"];
        cell.titleLabel.text = @"交流中心";
    } else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"zxft"];
        cell.titleLabel.text = @"在线法庭";
    } else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"ssfwzx"];
        cell.titleLabel.text = @"诉讼服务中心";
    } else if (indexPath.row == 3){
        cell.imageView.image = [UIImage imageNamed:@"zxzhzx"];
        cell.titleLabel.text = @"执行指挥中心";
    } else if (indexPath.row == 4){
        cell.imageView.image = [UIImage imageNamed:@"zxlx"];
        cell.titleLabel.text = @"在线联系";
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
        [self callPhone];
    } else if (indexPath.row == 1){
        GYNavWebView *navWebVC = [[GYNavWebView alloc]init];
        navWebVC.webUrl = @"http://www.sxgaofa.cn/ts/index";
        navWebVC.myTitle = @"在线法庭";
        [self.navigationController pushViewController:navWebVC animated:YES];
    } else if (indexPath.row == 2){
        GYNavWebView *navWebVC = [[GYNavWebView alloc]init];
        navWebVC.webUrl = @"http://www.sxgaofa.cn/web/index";
        navWebVC.myTitle = @"诉讼服务中心";
        [self.navigationController pushViewController:navWebVC animated:YES];
    } else if (indexPath.row == 3){
        GYGuideListVC *guideListVC = [[GYGuideListVC alloc]init];
        [self.navigationController pushViewController:guideListVC animated:YES];
    } else if (indexPath.row == 4){
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
