//
//  GYNoticePucCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/9.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNoticePucCell.h"

@interface GYNoticePucCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ajzhLabel;


@end

@implementation GYNoticePucCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    // Initialization code
}


-(void)setLosePeopleModel:(GYNPModel *)losePeopleModel {
    _losePeopleModel = losePeopleModel;
    self.nameLabel.text = losePeopleModel.xm;
    self.ajzhLabel.text = losePeopleModel.ahqc;
}

- (void)setScListModel:(GYSCListModel *)scListModel {
    _scListModel = scListModel;
    self.nameLabel.text = scListModel.ahqc;
    self.ajzhLabel.text = [NSString stringWithFormat:@"立案日期:%@",scListModel.larq];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
