//
//  GYSpFourthCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/5/15.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSpFourthCell.h"

@interface GYSpFourthCell ()
@property (strong, nonatomic) IBOutlet UILabel *kssjLabel;
@property (strong, nonatomic) IBOutlet UILabel *jssjLabel;
@property (strong, nonatomic) IBOutlet UIView *detailView;

@end


@implementation GYSpFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
    
}

- (void)setTsxxModel:(GYSpSXxxModel *)tsxxModel{
    _tsxxModel = tsxxModel;
    self.kssjLabel.text = tsxxModel.kssj;
    self.jssjLabel.text = tsxxModel.jssj;
    self.ktddLabel.text = tsxxModel.ftmc;
}

-(void)setSxbgModel:(GYSpSxbgModel *)sxbgModel{
    _sxbgModel = sxbgModel;
    self.kssjLabel.text = sxbgModel.qsrq;
    self.jssjLabel.text = sxbgModel.jsrq;
    self.ktddLabel.text = sxbgModel.bglxmc;
}

-(void)setCxbgModel:(GYSpCxbgModel *)cxbgModel{
    _cxbgModel = cxbgModel;
    self.kssjLabel.text = cxbgModel.jyzptrq;
    self.jssjLabel.text = cxbgModel.cxbglxmc;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
