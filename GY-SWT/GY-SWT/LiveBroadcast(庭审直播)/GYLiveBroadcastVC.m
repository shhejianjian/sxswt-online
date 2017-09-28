//
//  GYLiveBroadcastVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYLiveBroadcastVC.h"
#import "MXConstant.h"

@interface GYLiveBroadcastVC ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation GYLiveBroadcastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mxNavigationItem.title = @"庭审直播";
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.sxgaofa.cn/ts/index"];
    
    [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    _myWebView.scalesPageToFit=YES;
    
    _myWebView.multipleTouchEnabled=YES;
    
    _myWebView.userInteractionEnabled=YES;
}


//几个代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
}


@end
