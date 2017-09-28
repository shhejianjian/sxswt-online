//
//  MXConstant.h
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#ifndef MXConstant_h
#define MXConstant_h



#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreenIphone5    (([[UIScreen mainScreen] bounds].size.width)>320)
#define KScreenW [[UIScreen mainScreen]bounds].size.width
#define KScreenH [[UIScreen mainScreen]bounds].size.height
#define LBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define bottonBtnColor LBColor(12,59,79)
#define bottonBackgroundColor LBColor(209,43,64)
#define bottonBackgroundBlueColor LBColor(131,94,235)
#define newsSelectBackColor LBColor(44,137,192)
#define wslaGrayColor LBColor(154,163,176)
#define wslapurpleColor LBColor(131,94,215)
#define wslagreenColor LBColor(41,179,137)
#define wslaredColor LBColor(211,43,64)
#define dhButtonColor LBColor(233,134,87)

#define LBRandomColor LBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define NAVH 64.0
//#import "UIView+Frame.h"
//#import "UIColor+Expanded.h"
//#import "LxButton.h"
//#import "UILabel+LXLabel.h"

#import "GYHttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "UIView+Add.h"
#import "NSString+Add.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "GYLoginModel.h"
#import "UIView+Extension.h"
#import "GYCheckInfoTool.h"
#import "MJRefresh.h"
#import "UIViewController+MXNavigation.h"
#import "MXNavigationItem.h"
#import "MXBarButtonItem.h"
//#import "TBCityIconFont.h"
//#import "UIImage+TBCityIconFont.h"
#import "GYConst.h"
#import "UIImageView+WebCache.h"

#endif /* MXConstant_h */
