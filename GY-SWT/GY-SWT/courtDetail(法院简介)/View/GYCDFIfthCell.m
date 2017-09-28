//
//  GYCDFIfthCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCDFIfthCell.h"

@interface GYCDFIfthCell ()

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *zzmmLabel;
@property (strong, nonatomic) IBOutlet UILabel *jgLabel;
@property (strong, nonatomic) IBOutlet UILabel *dwzwLabel;

@end
@implementation GYCDFIfthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    // Initialization code
}

-(void)setFifthSwhModel:(GYSWHModel *)fifthSwhModel {
    _fifthSwhModel = fifthSwhModel;
    self.nameLabel.text = fifthSwhModel.mcName;
    self.zzmmLabel.text = fifthSwhModel.zzmmmc;
    self.jgLabel.text = fifthSwhModel.jgmc;
    self.dwzwLabel.text = fifthSwhModel.dwmc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
