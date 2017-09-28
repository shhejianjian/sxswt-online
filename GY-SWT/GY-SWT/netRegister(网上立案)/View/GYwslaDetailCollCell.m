//
//  GYwslaDetailCollCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/3/2.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYwslaDetailCollCell.h"

@interface GYwslaDetailCollCell ()

@end

@implementation GYwslaDetailCollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myImageView.layer.cornerRadius = 5;
    self.myImageView.layer.masksToBounds = YES;

    // Initialization code
}

@end
