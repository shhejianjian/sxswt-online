//
//  GYNRHomeCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYNetRegistModel.h"
@interface GYNRHomeCell : UITableViewCell
@property (nonatomic, strong) GYNetRegistModel *nrModel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

@end
