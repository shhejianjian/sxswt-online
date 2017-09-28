//
//  GYCourtListCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/8/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCourtListCell.h"
#import "ZFColor.h"
@interface GYCourtListCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation GYCourtListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setCourtBtn.layer.borderWidth = 1;
    self.setCourtBtn.layer.cornerRadius = 5;
    self.setCourtBtn.layer.borderColor = ZFSystemBlue.CGColor;
    // Initialization code
}

-(void)setCourtListModel:(GYCourtListModel *)courtListModel{
    _courtListModel =courtListModel;
    self.titleLabel.text = courtListModel.dmms;
}

- (IBAction)setCourtBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ChooseCourtWithBtnTag:)]) {
        [self.delegate ChooseCourtWithBtnTag:sender.tag];
    }
}



@end
