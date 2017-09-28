//
//  GYCourtNaviVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/28.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCourtNaviVC.h"
#import "MXConstant.h"
#import "GYCourtNavDetailVC.h"

@interface GYCourtNaviVC ()
@property (strong, nonatomic) IBOutlet UIImageView *myMapImage;
@property (strong, nonatomic) IBOutlet UIButton *enterBtn;
@property (strong, nonatomic) IBOutlet UIImageView *enterPic;

@end

@implementation GYCourtNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_name"];
    self.mxNavigationItem.title = title;
    [self loadImageUrl];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadImageUrl {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    [GYHttpTool postImage:fydh_ImageUrl ticket:@"" params:params success:^(id json) {
        self.myMapImage.image = [UIImage imageWithData:json];
        self.enterBtn.hidden = NO;
        self.enterPic.hidden = NO;
        [MBProgressHUD hideHUDForView:self.view];

    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)enterBtnClick:(id)sender {
    GYCourtNavDetailVC *detailVC = [[GYCourtNavDetailVC alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
