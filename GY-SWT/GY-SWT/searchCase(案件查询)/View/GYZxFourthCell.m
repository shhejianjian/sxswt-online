//
//  GYZxFourthCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYZxFourthCell.h"

@interface GYZxFourthCell ()
@property (strong, nonatomic) IBOutlet UILabel *jafsLabel;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *jasjLabel;
@property (strong, nonatomic) IBOutlet UILabel *cbrLabel;

@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYZxFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
