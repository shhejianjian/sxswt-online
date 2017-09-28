//
//  GYSCZXDetailSecondVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCZXDetailSecondVC.h"
#import "MXConstant.h"
#import "GYZXSegmentView.h"


@interface GYSCZXDetailSecondVC ()<GYZXSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYSCZXDetailSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    
    GYZXSegmentView *segView=[[GYZXSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"财产查控",@"财产处置",@"款额分配",@"执行暂缓"];
    segView.titleFont = Font(15);
    
    // Do any additional setup after loading the view from its nib.
}

-(void)segmentView:(GYZXSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    
}


@end
