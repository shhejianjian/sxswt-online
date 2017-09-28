//
//  PasswordAlertView.m
//  JCChartProject
//
//  Created by 何键键 on 17/6/7.
//  Copyright © 2017年 JC. All rights reserved.
//

#import "PasswordAlertView.h"
#import "MBProgressHUD+MJ.h"
#import "HCGDatePickerAppearance.h"



@interface PasswordAlertView ()
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property(nonatomic,strong)UIView *bGView;

@end

@implementation PasswordAlertView

-(instancetype)initWithAlertViewHeight:(CGFloat)height
{
    self=[super init];
    if (self) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"PasswordAlertView" owner:self options:nil];
        self = [nib objectAtIndex:0];
        self.layer.cornerRadius = 5;
        self.center = CGPointMake(MAINSCREENwidth/2, MAINSCREENheight/2-80);
        self.bounds = CGRectMake(0, 0, MAINSCREENwidth-30-30, height);
        [WINDOWFirst addSubview:self];
        self.sureBtn.layer.cornerRadius = 5;
        self.cancelBtn.layer.cornerRadius = 5;
    }
    return self;
}

- (void)show:(BOOL)animated
{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak PasswordAlertView *weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (IBAction)BtnClick:(UIButton *)sender {
        [self hide:YES];
        if (self.ButtonClick) {
            self.ButtonClick(sender);
        }
}


- (IBAction)startTimeBtnClick:(UIButton *)sender {
    HCGDatePickerAppearance *picker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
        NSString *formatStr = @"yyyy-MM-dd";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatStr];
        [picker hide];
        [sender setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    [picker show];
}

- (IBAction)endTimeBtnClick:(UIButton *)sender {
    HCGDatePickerAppearance *picker = [[HCGDatePickerAppearance alloc]initWithDatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
        NSString *formatStr = @"yyyy-MM-dd";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatStr];
        [picker hide];
        [sender setTitle:[dateFormatter stringFromDate:date] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    [picker show];
}


- (void)hide:(BOOL)animated
{
    NSLog(@"hide");
    __weak PasswordAlertView *weakSelf = self;
    
    [UIView animateWithDuration:animated ?0.3: 0 animations:^{
        weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1,1);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration: animated ?0.3: 0 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,0.2,0.2);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
        }];
    }];
}

@end
