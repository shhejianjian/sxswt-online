//
//  CustomTabbarController.m
//  自定义tabbar
//
//  Created by Hanguoxiang on 15-1-28.
//  Copyright (c) 2015年 zhangyuanyuan. All rights reserved.
//

#import "CustomTabbarController.h"
#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H 60
#define BTNTAG 10000
#import "GYNRDetailFirstVC.h"
#import "GYNRDetailSecondVC.h"
#import "GYNRDetailThirdVC.h"
#import "MXConstant.h"
#import "GYNRDetailFourthVC.h"
@interface CustomTabbarController ()

@end

@implementation CustomTabbarController
{
    UIButton *_button;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
            }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self initControllers];
    [self creatTabbar:self.viewControllers.count];
    [self initControllers];
}
- (void)viewWillAppear:(BOOL)animated {
    self.mxNavigationItem.title = @"网上立案";
}

#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    GYNRDetailFirstVC *view1 = [[GYNRDetailFirstVC alloc]init];
    [self addViewControllers:view1 title:@"网上立案-基本信息"];
    
    GYNRDetailSecondVC *view2 = [[GYNRDetailSecondVC alloc]init];
    [self addViewControllers:view2 title:@"网上立案-当事人信息"];

    GYNRDetailThirdVC *view3 = [[GYNRDetailThirdVC alloc]init];
    [self addViewControllers:view3 title:@"网上立案-代理人信息"];

    GYNRDetailFourthVC *view4 = [[GYNRDetailFourthVC alloc]init];
    [self addViewControllers:view4 title:@"网上立案-上传资料"];
    
    
    //  照着上面添加控制球就行了
}
#pragma  mark - 添加子控制器
- (void)addViewControllers:(UIViewController *)childController title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
    childController.navigationItem.title = title;
    //  添加导航栏的背景颜色
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"sy2@2x"] forBarMetrics:UIBarMetricsDefault];
//    nav.navigationBar.tintColor  = [UIColor whiteColor];
    nav.navigationBarHidden = YES;
    [self addChildViewController:nav];
}
- (void)creatTabbar:(NSInteger)ControllersNum
{
    //  只需要该图片名字就行
    NSArray * normImage = @[@"first",@"second",@"third",@"fourth"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"first-selected",@"second-selected",@"third-selected",@"fourth-selected"];
    UIImageView *tabbar = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreen_Height-EACH_H, kScreen_Width, EACH_H)];
    tabbar.backgroundColor =  [UIColor whiteColor];
    tabbar.userInteractionEnabled = YES;
    for(int i = 0;i<self.viewControllers.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(EACH_W(self.viewControllers.count)*i, 0, EACH_W(self.viewControllers.count), EACH_H);
        [btn setImage:[UIImage imageNamed:normImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];
        
        btn.backgroundColor = [UIColor blackColor];
        btn.tag = BTNTAG+i;
        [tabbar addSubview:btn];
        if(btn.tag==BTNTAG)
        {
            [self btnSelect:btn];
        }
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:tabbar];
    
}
- (void)btnSelect:(UIButton *)sender
{
    switch (sender.tag) {
        case 10000:

            break;
        case 10001:

            break;
        case 10002:

            break;
        case 10003:

            break;
        default:
            break;
    }
    _button.selected =NO ;
    sender.selected = YES;
    _button = sender;
    self.selectedIndex = sender.tag-BTNTAG;
}
@end
