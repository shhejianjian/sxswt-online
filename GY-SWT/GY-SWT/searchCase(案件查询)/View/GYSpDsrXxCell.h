//
//  GYSpDsrXxCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYSPDsrModel.h"
#import "GYSPSpzzModel.h"

@interface GYSpDsrXxCell : UITableViewCell
@property (nonatomic, strong) GYSPDsrModel *spDsrModel;
@property (nonatomic, strong) GYSPSpzzModel *spDlrModel;
@property (nonatomic, copy) NSString *cbbmString;
@end
