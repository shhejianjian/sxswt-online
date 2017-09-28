//
//  MXTabBarController.m
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "MXTabBarController.h"
#import "MXNavigationController.h"
#import "GYHomeVC.h"



@interface MXTabBarController ()

@end

@implementation MXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildViews];
    
}


- (void)setUpChildViews
{
    GYHomeVC *homeC = [[GYHomeVC alloc] init];
    MXNavigationController *firstNaC = [[MXNavigationController alloc] initWithRootViewController:homeC];
    
    homeC.title = @"首页";
    
    self.viewControllers = @[firstNaC];
}




@end
