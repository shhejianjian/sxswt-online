//
//  GYPCDetailCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYPCDetailCell.h"

@interface GYPCDetailCell ()

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *telePhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation GYPCDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setBmllDetailModel:(GYBmllModel *)bmllDetailModel {
    _bmllDetailModel = bmllDetailModel;
    self.nameLabel.text = [NSString stringWithFormat:@"%@:",bmllDetailModel.xm];
    self.telePhoneLabel.text = bmllDetailModel.sj;
    self.addressLabel.text = bmllDetailModel.gzdwmc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
