//
//  GYNRHomeCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRHomeCell.h"

@interface GYNRHomeCell ()

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation GYNRHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setNrModel:(GYNetRegistModel *)nrModel {
    _nrModel = nrModel;
    self.typeLabel.text = nrModel.clztmc;
    self.ahqcLabel.text = nrModel.ajbh;
    if ([nrModel.tjrq isEqualToString:@""]) {
        self.timeLabel.text = @"";
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"申请日期:%@",nrModel.tjrq];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
