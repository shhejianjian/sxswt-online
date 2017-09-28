//
//  GYCDSecondCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCDSecondCell.h"


@interface GYCDSecondCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation GYCDSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    // Initialization code
}

-(void)setSecondSwhModel:(GYBmznModel *)secondSwhModel {
    _secondSwhModel = secondSwhModel;
    self.nameLabel.text = secondSwhModel.organizeName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
