//
//  GYNoticePucCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GYNPModel.h"
#import "GYSCListModel.h"
@interface GYNoticePucCell : UITableViewCell
@property (nonatomic, strong) GYNPModel *losePeopleModel;
@property (nonatomic, strong) GYSCListModel *scListModel;

@end
