//
//  GYCourtNavDetailVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/28.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCourtNavDetailVC.h"
#import "MXConstant.h"
#import "ZFDropDown.h"
#import "GYLoginVC.h"
#import "GYTourVC.h"
#import "GYZxTianDVC.h"
#import "GYNavMapVC.h"

@interface GYCourtNavDetailVC ()<ZFDropDownDelegate>
@property (nonatomic, strong) ZFDropDown * dropDown1;
@property (nonatomic, strong) ZFDropDown * dropDown2;
@property (nonatomic, strong) ZFTapGestureRecognizer * tap;
@property (nonatomic, strong) NSArray * data1;
@property (nonatomic, strong) NSArray * data2;

@end

@implementation GYCourtNavDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_name"];
    self.mxNavigationItem.title = title;
    
    self.data1 = @[@"我是游客",@"诉讼参与人"];
    self.data2 = @[@"执行天地",@"导航地图"];
    
    self.dropDown1 = [[ZFDropDown alloc] initWithFrame:CGRectMake(180, 150, 160, 40) pattern:kDropDownPatternCustom];
    self.dropDown1.delegate = self;
    self.dropDown1.borderStyle = kDropDownTopicBorderStyleRect;
    [self.view addSubview:self.dropDown1];
    
    self.dropDown2 = [[ZFDropDown alloc] initWithFrame:CGRectMake(180, 280, 160, 40) pattern:kDropDownPatternCustom];
    self.dropDown2.delegate = self;
    self.dropDown2.borderStyle = kDropDownTopicBorderStyleRect;
    [self.view addSubview:self.dropDown2];
    
    
    self.tap = [[ZFTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:self.tap];
}

/**
 *  self.view添加手势取消dropDown第一响应
 */
- (void)tapAction{
    [self.dropDown1 resignDropDownResponder];
    [self.dropDown2 resignDropDownResponder];
}


#pragma mark - ZFDropDownDelegate

- (NSArray *)itemArrayInDropDown:(ZFDropDown *)dropDown{
    if (dropDown == self.dropDown1) {
        return self.data1;
    } else if (dropDown == self.dropDown2){
        return self.data2;
    }
    return nil;
}

- (UIView *)viewForTopicInDropDown:(ZFDropDown *)dropDown{
    if (dropDown == self.dropDown1) {
        UIView *back1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
        back1.backgroundColor = dhButtonColor;
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        imageView1.image = [UIImage imageNamed:@"yd"];
        imageView1.backgroundColor = [UIColor clearColor];
        [back1 addSubview:imageView1];
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(130, 5, 25, 30)];
        imageView2.image = [UIImage imageNamed:@"icon_down2"];
        imageView2.backgroundColor = [UIColor clearColor];
        [back1 addSubview:imageView2];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(40, 5, 80, 30);
        [button1 setTitle:@"引导台" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            //注意这里的target是dropDown, 不是self
        [button1 addTarget:dropDown action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
        [back1 addSubview:button1];
        return back1;

    } else if (dropDown == self.dropDown2){
        UIView *back1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
        back1.backgroundColor = dhButtonColor;
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        imageView1.image = [UIImage imageNamed:@"tianping"];
        imageView1.backgroundColor = [UIColor clearColor];
        [back1 addSubview:imageView1];
        UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(130, 5, 25, 30)];
        imageView2.image = [UIImage imageNamed:@"icon_down2"];
        imageView2.backgroundColor = [UIColor clearColor];
        [back1 addSubview:imageView2];
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(40, 5, 80, 30);
        [button1 setTitle:@"功能介绍" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //注意这里的target是dropDown, 不是self
        [button1 addTarget:dropDown action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
        [back1 addSubview:button1];
        return back1;
    }
    return nil;

}

- (UITableViewCell *)dropDown:(ZFDropDown *)dropDown tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIndentifier = @"MyTableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    if (dropDown == self.dropDown1) {
        cell.textLabel.text = self.data1[indexPath.row];
        
    } else if (dropDown == self.dropDown2){
        cell.textLabel.text = self.data2[indexPath.row];
    }
    cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (NSUInteger)numberOfRowsToDisplayIndropDown:(ZFDropDown *)dropDown itemArrayCount:(NSUInteger)count{
    return 2;
}

- (void)dropDown:(ZFDropDown *)dropDown didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dropDown == self.dropDown1) {
        if (indexPath.row == 0) {
            GYTourVC *tourVC = [[GYTourVC alloc]init];
            [self.navigationController pushViewController:tourVC animated:YES];
        } else if (indexPath.row == 1){
            GYLoginVC *loginVC = [[GYLoginVC alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    } else if (dropDown == self.dropDown2){
        if (indexPath.row == 0) {
            GYZxTianDVC *zxtdVC = [[GYZxTianDVC alloc]init];
            [self.navigationController pushViewController:zxtdVC animated:YES];
        } else if (indexPath.row == 1){
            GYNavMapVC *navMapVC = [[GYNavMapVC alloc]init];
            [self.navigationController pushViewController:navMapVC animated:YES];
        }
    }
}

@end
