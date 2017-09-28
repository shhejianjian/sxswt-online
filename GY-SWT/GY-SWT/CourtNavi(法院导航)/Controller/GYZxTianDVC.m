//
//  GYZxTianDVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/28.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYZxTianDVC.h"
#import "MXConstant.h"
#import "MXConstant.h"
#import "GYCourtNavCell.h"
#import "GYGuideListVC.h"
#import "GYNoticePublicVC.h"

static NSString *ID=@"GYCourtNavCell";
@interface GYZxTianDVC ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation GYZxTianDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = @"执行天地";
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYCourtNavCell" bundle:nil] forCellReuseIdentifier:ID];

}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 3;
    
}


- (GYCourtNavCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYCourtNavCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYCourtNavCell alloc]init];
        
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"zxyd"];
        cell.titleLabel.text = @"执行引导";
    } else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"zxjd"];
        cell.titleLabel.text = @"执行进度";
    } else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"cxhmd"];
        cell.titleLabel.text = @"查询黑名单";
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
    if (indexPath.row == 0 || indexPath.row == 1) {
        GYGuideListVC *guideListVC = [[GYGuideListVC alloc]init];
        [self.navigationController pushViewController:guideListVC animated:YES];
    } else if (indexPath.row == 2){
        GYNoticePublicVC *noticePublic = [[GYNoticePublicVC alloc]init];
        [self.navigationController pushViewController:noticePublic animated:YES];
    }
}



@end
