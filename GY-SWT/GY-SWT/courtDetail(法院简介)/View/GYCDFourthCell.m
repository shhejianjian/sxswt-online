//
//  GYCDFourthCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCDFourthCell.h"

@interface GYCDFourthCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;
@property (strong, nonatomic) IBOutlet UILabel *doorLabel;


@end
@implementation GYCDFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    // Initialization code
}

-(void)setFourthSwhModel:(GYSWHModel *)fourthSwhModel {
    _fourthSwhModel = fourthSwhModel;
    self.nameLabel.text = fourthSwhModel.mcName;
    self.levelLabel.text = fourthSwhModel.fgdjmc;
    self.jobLabel.text = fourthSwhModel.zwmc;
    self.doorLabel.text = fourthSwhModel.departmc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
