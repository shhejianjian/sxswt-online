//
//  GYWssdListCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/3/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYWssdListCell.h"

@interface GYWssdListCell ()
@property (strong, nonatomic) IBOutlet UILabel *ahqcLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *detailView;

@end
@implementation GYWssdListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setKtggModel:(GYKtggModel *)ktggModel {
    _ktggModel = ktggModel;
    self.ahqcLabel.text = ktggModel.ahqc;
    self.titleLabel.text = ktggModel.fymc;
}

-(void)setWssdModel:(GYWssdModel *)wssdModel {
    _wssdModel = wssdModel;
    self.ahqcLabel.text = wssdModel.ahqc;
    self.titleLabel.text = wssdModel.xsmc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
