//
//  GYNewsInfoListCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNewsInfoListModel.h"
@interface GYNewsInfoListCell : UITableViewCell
@property (nonatomic, strong) GYNewsInfoListModel *newsInfoListModel;
@property (nonatomic, copy) NSString *imageFileUrl;

@end
