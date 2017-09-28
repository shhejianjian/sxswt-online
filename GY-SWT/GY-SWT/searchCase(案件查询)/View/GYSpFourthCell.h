//
//  GYSpFourthCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/5/15.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYSpSXxxModel.h"
#import "GYSpSxbgModel.h"
#import "GYSpCxbgModel.h"
@interface GYSpFourthCell : UITableViewCell
@property (nonatomic, strong) GYSpSXxxModel *tsxxModel;
@property (nonatomic, strong) GYSpSxbgModel *sxbgModel;
@property (nonatomic, strong) GYSpCxbgModel *cxbgModel;
@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabel;
@property (strong, nonatomic) IBOutlet UILabel *ktddLabel;

@end
