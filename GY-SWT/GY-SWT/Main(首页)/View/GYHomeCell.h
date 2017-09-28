//
//  GYHomeCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYTop2NewsModel.h"
@interface GYHomeCell : UITableViewCell
@property (nonatomic, strong) GYTop2NewsModel *newsModel;
@property (nonatomic, copy) NSString *imageFileUrl;
@end
