//
//  ZYLAlert.h
//  ZYLAlertController
//
//  Created by zhuyuelong on 16/6/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ClickAction)();

@interface ZYLAlert : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

/**
 * @param title    标题
 * @param message  提示内容
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)setTitle:(NSString *)title message:(NSString *)message;

/**
 * @brief 添加按钮及事件，多个按钮便多次调用，按钮按照添加顺序显示
 */
- (void)addBtnSheetTitle:(NSString *)title action:(ClickAction)action;

- (void)addBtnAlertTitle:(NSString *)title action:(ClickAction)action;

/**
 * @brief 显示提示框
 */
- (void)showAlertWithSender:(UIViewController *)sender;

- (void)showActionSheetWithSender:(UIViewController *)sender;

/**
 * @brief 只有确定按钮提示框，没点击事件
 */
+ (void)showAlertViewCertainWithTitle:(NSString *)title WithUIViewController:(UIViewController *)ViewControll;

@end
