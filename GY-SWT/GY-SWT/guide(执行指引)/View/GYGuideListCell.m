//
//  GYGuideListCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/25.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYGuideListCell.h"

@interface GYGuideListCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end

@implementation GYGuideListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;

    // Initialization code
}

- (void)setGuideListModel:(GYGuideListModel *)guideListModel{
    _guideListModel = guideListModel;
    self.titleLabel.text = guideListModel.title;
}
@end
