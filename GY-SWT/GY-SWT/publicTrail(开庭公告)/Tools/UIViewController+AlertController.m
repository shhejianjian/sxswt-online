//
//  UIViewController+AlertController.m
//  SVAlertController
//
//  Created by 李亮 on 2017/2/28.
//  Copyright © 2017年 theLastCc. All rights reserved.
//

#import "UIViewController+AlertController.h"
#import "SVAlertViewController.h"


@implementation UIViewController (AlertController)



- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(AlertAppearanceProcess)appearanceProcess actionsBlock:(AlertActionBlock)actionBlock{
    
    [self showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}
- (void)showActionSheetWithTitle:(NSString *)title
                         message:(NSString *)message
               appearanceProcess:(AlertAppearanceProcess)appearanceProcess
                    actionsBlock:(AlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0){
    
    [self showAlertWithPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}



- (void)showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(AlertAppearanceProcess)appearanceProcess actionsBlock:(AlertActionBlock)actionBlock{
    
    if (appearanceProcess)
    {
        
        SVAlertViewController * alertMaker = [SVAlertViewController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        
        if (!alertMaker) {
            return ;
        }
        appearanceProcess(alertMaker);
        
        alertMaker.alertActionsConfig(actionBlock);
        
        [self presentViewController:alertMaker animated:YES completion:nil];
    }
    
    
}
@end
