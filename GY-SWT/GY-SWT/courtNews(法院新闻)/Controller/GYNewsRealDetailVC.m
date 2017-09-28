//
//  GYNewsRealDetailVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNewsRealDetailVC.h"
#import "MXConstant.h"


@interface GYNewsRealDetailVC ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation GYNewsRealDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mxNavigationItem.title = self.myTitle;
    [self setUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setUI {
    self.titleLabel.text = self.newsDetail.title;
    self.timeLabel.text = [NSString stringWithFormat:@"发布日期:%@",self.newsDetail.pubdate];
    CGSize addressLabelSize = [self sizeWithText:self.titleLabel.text Font:[UIFont systemFontOfSize:17] MaxW:self.titleLabel.width];
    self.titleViewHeightConstraint.constant = 8+addressLabelSize.height+self.timeLabel.height+8+8;
    
    
    NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://1.85.16.50:8082/bs/news/getNewsDetial.shtml?id=%@",self.newsDetail.id]];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.myWebView.backgroundColor = [UIColor clearColor];
    self.myWebView.opaque = NO;
}









- (CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font MaxW:(CGFloat)maxW
{
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    attr[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
}



@end
