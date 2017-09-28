//
//  GYGuideWebVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/25.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYGuideWebVC.h"
#import "MXConstant.h"
@interface GYGuideWebVC ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation GYGuideWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-执行指引",fyjc];
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://1.85.16.50:8082/bs/news/getsxNewsDetial.shtml?id=%ld&typeid=%ld",(long)self.guideModel.id,self.guideModel.typeid]];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.myWebView.backgroundColor = [UIColor clearColor];
    self.myWebView.opaque = NO;
}

@end
