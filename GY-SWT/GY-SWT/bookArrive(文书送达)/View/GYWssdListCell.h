//
//  GYWssdListCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/3/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYWssdModel.h"
#import "GYKtggModel.h"
@interface GYWssdListCell : UITableViewCell
@property (nonatomic, strong) GYWssdModel *wssdModel;
@property (nonatomic, strong) GYKtggModel *ktggModel;

@end
