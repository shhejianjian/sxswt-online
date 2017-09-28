//
//  UIViewController+AlertController.h
//  SVAlertController
//
//  Created by 李亮 on 2017/2/28.
//  Copyright © 2017年 theLastCc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 SVAlertViewController: alert构造块
 */
typedef void(^AlertAppearanceProcess)(SVAlertViewController * alertMaker);

/**
 * AlertController: alert按钮执行回调
 */
typedef void (^AlertActionBlock)(NSInteger buttonIndex, UIAlertAction *action, SVAlertViewController * alertSelf);



@interface UIViewController (AlertController)


/**
 * alert方式
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(AlertAppearanceProcess)appearanceProcess actionsBlock:(AlertActionBlock)actionBlock NS_AVAILABLE_IOS(8.0);

/**
 * sheet方式
 */
- (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
               appearanceProcess:(AlertAppearanceProcess)appearanceProcess
                    actionsBlock:(AlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END
