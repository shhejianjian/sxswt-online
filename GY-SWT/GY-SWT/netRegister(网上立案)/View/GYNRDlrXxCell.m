//
//  GYNRDlrXxCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDlrXxCell.h"

@interface GYNRDlrXxCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *dlrNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *wtrNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dlrTelephoneLabel;


@end

@implementation GYNRDlrXxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

-(void)setDlrModel:(GYNRDlrXxModel *)dlrModel {
    _dlrModel = dlrModel;
    self.dlrNameLabel.text = dlrModel.mc;
    self.wtrNameLabel.text = dlrModel.wtrmc;
    self.dlrTelephoneLabel.text = dlrModel.ydhm;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
