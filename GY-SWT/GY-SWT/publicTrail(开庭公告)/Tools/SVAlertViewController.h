//
//  SVAlertViewController.h
//  SVAlertController
//
//  Created by 李亮 on 2017/2/28.
//  Copyright © 2017年 theLastCc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVAlertViewController;

typedef void (^AlertActionBlock)(NSInteger buttonIndex, UIAlertAction *action, SVAlertViewController * alertSelf);

typedef void (^AlertActionsConfig)(AlertActionBlock actionBlock);



typedef SVAlertViewController * (^AlertActionTitle)(NSString *title);


NS_CLASS_AVAILABLE_IOS(8_0) @interface SVAlertViewController : UIAlertController

/**
 * Actions设置
 */
- (AlertActionsConfig)alertActionsConfig;


/**
 * 默认
 */
- (AlertActionTitle)addActionDefaultTitle;

/**
 * 取消
 */
- (AlertActionTitle)addActionCancelTitle;

/**
 * 警告
 */
- (AlertActionTitle)addActionDestructiveTitle;

@end
