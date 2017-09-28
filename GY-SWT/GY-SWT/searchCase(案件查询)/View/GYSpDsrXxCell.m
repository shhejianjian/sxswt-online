//
//  GYSpDsrXxCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSpDsrXxCell.h"

@interface GYSpDsrXxCell ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *ssdwLabel;
@property (strong, nonatomic) IBOutlet UILabel *dsrmcLabel;
@property (strong, nonatomic) IBOutlet UILabel *dsrlxLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabel;

@end

@implementation GYSpDsrXxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSpDsrModel:(GYSPDsrModel *)spDsrModel {
    _spDsrModel = spDsrModel;
    self.ssdwLabel.text = spDsrModel.ssdwmc;
    self.dsrlxLabel.text = spDsrModel.dsrlxmc;
    self.dsrmcLabel.text = spDsrModel.mc;
}

-(void)setSpDlrModel:(GYSPSpzzModel *)spDlrModel {
    _spDlrModel = spDlrModel;
    self.firstLabel.text = @"承办部门:";
    self.secondLabel.text = @"承办人员:";
    self.thirdLabel.text = @"出庭职务:";
    self.ssdwLabel.text = self.cbbmString;
    self.dsrmcLabel.text = spDlrModel.drjsmc;
    self.dsrlxLabel.text = spDlrModel.xm;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
