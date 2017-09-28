//
//  CustomerScrollView.m
//  colloctionViewTest
//
//  Created by jerry on 16/12/15.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "CustomerScrollView.h"
#import "NSString+WJExtension.h"
#import "UIView+WJExtension.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NavBarH 64
#define TabBarH 44
#define WIDTH_RATE (375/375)   // 屏幕宽度系数（以4.7英寸为基准）
#define HEIGHT_RATE (667/667)

#define kScreenIphone5    (([[UIScreen mainScreen] bounds].size.width)>320)
#define ipad79cun    (([[UIScreen mainScreen] bounds].size.width)==768)
#define ipad129cun    (([[UIScreen mainScreen] bounds].size.width)==1024)

#define BGColor [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4]
#define NumberOfSinglePage 8// 一个页面可容纳的最多按钮数
#define leftRightGap 25*WIDTH_RATE
#define topBottomGap 35
#define ViewMargin (kScreenIphone5 == 0)?10:20
#define BtnWH (kScreenIphone5 == 0)? 50: 60

@interface CustomerScrollView ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView * contentScrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@end

@implementation CustomerScrollView

#pragma mark - getter


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 属性初始值
        if (ipad79cun) {
            self.viewSize = CGSizeMake(100, 100);
        } else if (ipad129cun){
            self.viewSize = CGSizeMake(120, 120);
        } else {
            self.viewSize = CGSizeMake(BtnWH, BtnWH);
        }
        self.numberOfSinglePage = NumberOfSinglePage;
        self.viewGap = leftRightGap;
        self.viewMargin = ViewMargin;
        // 初始化
        [self initDataAndSubviews];
    }
    return self;
}

-(void)initDataAndSubviews{
    
    if (!self.dataArr) {
        // 加载默认测试数据
        NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"funKeyboardData.plist" ofType:nil];
        _dataArr = [NSArray arrayWithContentsOfFile:dataPath];
    }
    
    NSInteger pageCount = self.dataArr.count / self.numberOfSinglePage;
    if (self.dataArr.count % self.numberOfSinglePage > 0) {
        pageCount += 1;
    }
    
    
    UIScrollView * contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentScrollView = contentScrollView;
    _contentScrollView.delegate = self;
    contentScrollView.backgroundColor = BGColor;
    contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * pageCount, self.frame.size.height);
    contentScrollView.pagingEnabled = YES;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;

    for (int i = 0; i < pageCount; i++) {
        [self addBtnsWithPageNum:i];
    }
    
    [self addSubview:contentScrollView];

    // 添加pageControl
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(SCREEN_WIDTH/2, self.height-10, 0, 0);
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = pageCount;
    _pageControl = pageControl;
    [self addSubview:_pageControl];
    [self bringSubviewToFront:_pageControl];
    
}

// 循环添加按钮
-(void)addBtnsWithPageNum:(NSInteger)number{
    
    // 添加按钮
    NSInteger maxCol = 4;
    NSInteger maxRow = 2;
    
    CGFloat btnW = self.viewSize.width * WIDTH_RATE;
    CGFloat btnH = self.viewSize.height * HEIGHT_RATE;
    CGFloat leftRightMargin = (SCREEN_WIDTH - (maxCol * btnW + (maxCol-1) * leftRightGap))/2; // 左右内边距;
    CGFloat topBottomMargin = (self.height - (maxRow * btnH + (topBottomGap+30)))/2;
    
    NSInteger count = self.dataArr.count - (number * self.numberOfSinglePage);
    NSInteger indexCount;
    if (count > 0 && count <= self.numberOfSinglePage) {
        
        indexCount = count;
    }else if(count > self.numberOfSinglePage){
        
        indexCount = self.numberOfSinglePage;
    }else{
        
        return;
    }
    

    for (int i = 0; i<indexCount; i++) {
        UIButton  * btn = [[UIButton alloc] init];
        
        int col = i % maxCol;
        int row = i / maxCol;
        NSInteger index = i + number * self.numberOfSinglePage;
        NSDictionary * btnDic = self.dataArr[index];
        
        //设置图片内容（使图片和文字水平居中显示）
        btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        //btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:btnDic[@"title"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnDic[@"image"]] forState:UIControlStateNormal];
        //[btn setTitle:btnDic[@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (ipad79cun) {
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        } else if (ipad129cun) {
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        } else {
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        
        // 设置图片frame
        
        btn.x = col * (btnW + leftRightGap) + leftRightMargin + number * self.width;
        btn.y = row * (btnH + topBottomGap) + topBottomMargin;
        
        btn.width = btnW;
        btn.titleLabel.width = btn.width;
        btn.height = btnH;
        btn.tag = index;
        
        if (SCREEN_WIDTH == 320) {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+10 ,-btn.imageView.frame.size.width-20, 0,0)];
        }
        if (SCREEN_WIDTH == 375) {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+20 ,-btn.imageView.frame.size.width-8, 0,0)];
        }
        if (SCREEN_WIDTH ==414) {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+30 ,-btn.imageView.frame.size.width-10, 0,0)];
        }
        if (SCREEN_WIDTH == 768) {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+35 ,-btn.imageView.frame.size.width-4, 0,0)];
        }
        if (SCREEN_WIDTH == 1024) {
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.currentImage.size.height+40 ,-btn.imageView.frame.size.width+5, 0,0)];
        }

        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (btn.width - btn.imageView.width)/2 ,0 ,0)];//图片距离右边框距离减少图片的宽度，其它不变
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentScrollView addSubview:btn];
    }

}

// 按钮点击事件

-(void)btnClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(btnClickWithBtnTag:)]) {
        [self.delegate btnClickWithBtnTag:btn.tag];
    }
}

#pragma mark - scroll delegate 

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger correntCount = (scrollView.contentOffset.x + self.width/2)/self.width;
    self.pageControl.currentPage = correntCount;
}

@end
