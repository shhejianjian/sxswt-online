//
//  GYAddNCPushVC.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNRDsrXxModel.h"

@protocol GYAddNCPushVCDelegate <NSObject>

- (void)passFirstValueForName:(NSString *)name AndSex:(NSString *)sex AndSfzhm:(NSString *)sfzhm AndLxdz:(NSString *)lxdz AndSjhm:(NSString *)sjhm AndSfdzsd:(BOOL)sfdzsd AndSffrsw:(BOOL)sffrdw AndJlid:(NSString *)jlid;
- (void)passSecondValueForName:(NSString *)name AndZjlx:(NSString *)zjlx AndZjlxmc:(NSString *)zjlxmc AndZjhm:(NSString *)zjhm AndZzmc:(NSString *)zzmc AndDwxz:(NSString *)dwxz AndSjhm:(NSString *)sjhm AndSfdzsd:(BOOL)sfdzsd AndSffrsw:(BOOL)sffrdw AndJlid:(NSString *)jlid;
- (void)passThirdValueForZzmc:(NSString *)zzmc AndZzdz:(NSString *)zzdz AndZzdm:(NSString *)zzdm AndDwxz:(NSString *)dwxz AndSjhm:(NSString *)sjhm AndSfdzsd:(BOOL)sfdzsd AndSffrsw:(BOOL)sffrdw AndJlid:(NSString *)jlid;
@end
@interface GYAddNCPushVC : UIViewController
@property (nonatomic, weak) id <GYAddNCPushVCDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *changeValueView;


//firstView
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *switchView;
@property (strong, nonatomic) IBOutlet UIButton *saveInfoBtn;
@property (strong, nonatomic) IBOutlet UIButton *messageBtn;
@property (strong, nonatomic) IBOutlet UIButton *frdwBtn;
@property (copy ,nonatomic) NSString *sexStr;

@property (strong, nonatomic) IBOutlet UITextField *firstViewNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstViewSfzhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstViewLxdzTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstViewLxdhTextField;



//secondView
@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UIButton *secondMessageBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondFrdwBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondSaveInfoBtn;
@property (strong, nonatomic) IBOutlet UITextField *secondViewFrdbmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondViewZjlxTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondViewZjhmTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondViewZzmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondViewDwxzTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondLxdhTextField;




//thirdView
@property (strong, nonatomic) IBOutlet UIView *thirdView;
@property (strong, nonatomic) IBOutlet UIButton *thirdMessageBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdFrdwBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdSaveInfoBtn;
@property (strong, nonatomic) IBOutlet UITextField *thirdViewZzmcTextField;
@property (strong, nonatomic) IBOutlet UITextField *thirdViewZzdmTextField;
@property (strong, nonatomic) IBOutlet UITextField *thirdViewDwxzTextField;
@property (strong, nonatomic) IBOutlet UITextField *thirdViewLxdhTextField;
@property (strong, nonatomic) IBOutlet UITextField *thirdViewZzdzTextField;


//update
@property (nonatomic, strong) GYNRDsrXxModel *updateModel;


@end
