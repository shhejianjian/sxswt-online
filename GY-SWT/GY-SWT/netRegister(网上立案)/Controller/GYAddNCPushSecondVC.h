//
//  GYAddNCPushSecondVC.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNRDlrXxModel.h"
@protocol GYAddNCPushSecondVCDelegate <NSObject>

- (void)passValueForWtrName:(NSString *)name AndWtrId:(NSString *)ID Andlszjh:(NSString *)lszjh AndDlrName:(NSString *)dlrName AndDlrSjhm:(NSString *)dlrSjhm AndDlrSfzhm:(NSString *)dlrSfzhm AndJlid:(NSString *)jlid AndSfdzsd:(BOOL)sfdzsd;

@end

@interface GYAddNCPushSecondVC : UIViewController
@property (nonatomic, copy) NSString *ajbsStr;
@property (nonatomic, weak) id <GYAddNCPushSecondVCDelegate> delegate;

@property (nonatomic, strong) GYNRDlrXxModel *updateModel;

@property (strong, nonatomic) IBOutlet UIButton *sdBtn;
@property (strong, nonatomic) IBOutlet UIButton *saveInfoBtn;
@property (strong, nonatomic) IBOutlet UITextField *wtrNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lszjhTextField;
@property (strong, nonatomic) IBOutlet UITextField *dlrmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *dlrsjTextField;
@property (strong, nonatomic) IBOutlet UITextField *sfzhmTextField;
@end
