//
//  GYCDThirdCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCDThirdCell.h"

@interface GYCDThirdCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;

@end

@implementation GYCDThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    // Initialization code
}

-(void)setThirdSwhModel:(GYSWHModel *)thirdSwhModel {
    _thirdSwhModel = thirdSwhModel;
    self.nameLabel.text = thirdSwhModel.mcName;
    self.levelLabel.text = thirdSwhModel.fgdjmc;
    self.jobLabel.text = thirdSwhModel.zwmc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
