//
//  GYNRSegmentView.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/14.
//  Copyright © 2017年 GY. All rights reserved.
//

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a/1.0]
#define ImageName(name) [UIImage imageNamed:name]
#define Font(x) [UIFont systemFontOfSize:x]
#define Frame(x,y,w,h) CGRectMake(x, y, w, h)
#define Size(w,h) CGSizeMake(w, h)
#define Point(x,y) CGPointMake(x, y)
#define ZeroRect CGRectZero
#define TouchUpInside UIControlEventTouchUpInside
#define NormalState UIControlStateNormal
#define SelectedState UIControlStateSelected
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WH(x) (x)*SCREEN_WIDTH/375.0
#define MainRedColor RGB(120,195,236)
#define selectBackColor RGB(44,137,192)
#define BlackFontColor RGB(34,34,34)
#define WhiteColor RGB(255,255,255)
#define ContentBackGroundColor RGB(238,238,238)
#import <UIKit/UIKit.h>


@class GYNRSegmentView;
@protocol GYNRSegmentViewDelegate <NSObject>
-(void)segmentView:(GYNRSegmentView *)segmentView didSelectIndex:(NSInteger)index;
@end
@interface GYNRSegmentView : UIView
@property (nonatomic) id <GYNRSegmentViewDelegate>delegate;
@property (nonatomic) NSArray * titles;
@property (nonatomic) UIColor * titleColor;//标题字体颜色
@property (nonatomic) UIColor * selectColor;//标题字体选中颜色
@property (nonatomic) UIColor * titleBackgroundColor;//标题背景颜色
@property (nonatomic) int selectIndex;
@property (nonatomic) UIFont * titleFont;
@property (nonatomic) UIView * dotView;
@end





@interface UIView (Category)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat w;
@property (nonatomic,assign) CGFloat h;
@end
