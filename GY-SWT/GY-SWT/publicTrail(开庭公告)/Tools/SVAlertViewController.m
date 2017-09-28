//
//  SVAlertViewController.m
//  SVAlertController
//
//  Created by 李亮 on 2017/2/28.
//  Copyright © 2017年 theLastCc. All rights reserved.
//

#import "SVAlertViewController.h"


#pragma mark - AlertActionModel
@interface AlertActionModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) UIAlertActionStyle style;

@end
@implementation AlertActionModel
- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}
@end


#pragma mark - SVAlertViewController
@interface SVAlertViewController ()

@property (nonatomic, strong) NSMutableArray * alertActionArray;

@end

@implementation SVAlertViewController

- (NSMutableArray *)alertActionArray
{
    if (_alertActionArray == nil) {
        _alertActionArray = [NSMutableArray array];
    }
    return _alertActionArray;
}

- (AlertActionsConfig)alertActionsConfig{
    
    
    void (^AlertActionsConfig)() = ^(AlertActionBlock actionBlock) {
        
        if (self.alertActionArray.count > 0)
        {
            //创建action
            __weak typeof(self)weakSelf = self;
            [self.alertActionArray enumerateObjectsUsingBlock:^(AlertActionModel *actionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionModel.title style:actionModel.style handler:^(UIAlertAction * _Nonnull action) {
                    
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    
                    if (actionBlock) {
                        actionBlock(idx, action, strongSelf);
                    }
                }];
                
                [self addAction:alertAction];
            }];
        }
        
    };
    return AlertActionsConfig;
//    return ^(AlertActionBlock actionBlock) {
//        
//    };
}

- (AlertActionTitle)addActionDefaultTitle
{
    return ^(NSString *title){
        AlertActionModel * actionModel = [[AlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.alertActionArray addObject:actionModel];
        
        return self;
    };
}

- (AlertActionTitle)addActionCancelTitle
{
    return ^(NSString *title){
        
        AlertActionModel * actionModel = [[AlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.alertActionArray addObject:actionModel];
        
        return self;
    };
}

- (AlertActionTitle)addActionDestructiveTitle
{
    SVAlertViewController * (^AlertActionTitle)() = ^(NSString *title){
        
        AlertActionModel * actionModel = [[AlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.alertActionArray addObject:actionModel];
        
        return self;
    };
    return AlertActionTitle;
}
@end
