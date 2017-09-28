//
//  GYSCZXTabbarVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCZXTabbarVC.h"
#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H 60
#define BTNTAG 10000
#import "GYSCZXDetailFirstVC.h"
#import "GYSCZXDetailSecondVC.h"
#import "GYSCZXDetailThirdVC.h"
#import "MXConstant.h"
#import "GYSCZXDetailFourthVC.h"
@interface GYSCZXTabbarVC ()

@end

@implementation GYSCZXTabbarVC
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
    self.mxNavigationItem.title = self.ahqcStr;
}

#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    GYSCZXDetailFirstVC *view1 = [[GYSCZXDetailFirstVC alloc]init];
    [self addViewControllers:view1 title:@"网上立案-基本信息"];
    
    GYSCZXDetailSecondVC *view2 = [[GYSCZXDetailSecondVC alloc]init];
    [self addViewControllers:view2 title:@"网上立案-当事人信息"];
    
    GYSCZXDetailThirdVC *view3 = [[GYSCZXDetailThirdVC alloc]init];
    [self addViewControllers:view3 title:@"网上立案-代理人信息"];
    
    GYSCZXDetailFourthVC *view4 = [[GYSCZXDetailFourthVC alloc]init];
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
    NSArray * normImage = @[@"zxfirst",@"zxsecond",@"zxthird",@"zxFourth"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"zxfrst-selected",@"zxsecond-selected",@"zxthird-selected",@"zxFourth-selected"];
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
    NSLog(@"被点了-%ld",(long)sender.tag);
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

