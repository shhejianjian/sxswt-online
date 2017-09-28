//
//  GYReDocumentVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYReDocumentVC.h"
#import "MXConstant.h"

@interface GYReDocumentVC ()
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation GYReDocumentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-裁判文书",fyjc];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://wenshu.court.gov.cn/Index"];
    
    [_myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    _myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    _myWebView.scalesPageToFit=YES;
    
    _myWebView.multipleTouchEnabled=YES;
    
    _myWebView.userInteractionEnabled=YES;
    // Do any additional setup after loading the view from its nib.
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
