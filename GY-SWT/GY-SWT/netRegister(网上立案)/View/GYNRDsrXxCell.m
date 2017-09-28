//
//  GYNRDsrXxCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/22.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDsrXxCell.h"


@interface GYNRDsrXxCell ()
@property (strong, nonatomic) IBOutlet UILabel *ygbgLabel;
@property (strong, nonatomic) IBOutlet UILabel *ygbgNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *zzdmLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdzLabel;

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *zzdmOrSfzhmLabel;
@property (strong, nonatomic) IBOutlet UILabel *lxdzOrZzmcLabel;

@end

@implementation GYNRDsrXxCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setGynrDsrxxModel:(GYNRDsrXxModel *)gynrDsrxxModel {
    _gynrDsrxxModel = gynrDsrxxModel;
    self.ygbgLabel.text = [NSString stringWithFormat:@"%@:",gynrDsrxxModel.ssdwmc];
    
    if ([gynrDsrxxModel.lxmc isEqualToString:@"非法人组织"]) {
        self.ygbgNameLabel.text = gynrDsrxxModel.zzmc;
        self.zzdmOrSfzhmLabel.text = @"组织代码:";
        self.lxdzOrZzmcLabel.text = @"联系地址:";
        self.zzdmLabel.text = gynrDsrxxModel.zzjgdm;
        self.lxdzLabel.text = gynrDsrxxModel.zzdz;
    } else if([gynrDsrxxModel.lxmc isEqualToString:@"自然人"]) {
        self.ygbgNameLabel.text = [NSString stringWithFormat:@"%@(%@)",gynrDsrxxModel.mc,gynrDsrxxModel.xbmc];
        self.zzdmOrSfzhmLabel.text = @"身份证号:";
        self.lxdzOrZzmcLabel.text = @"联系地址:";
        self.zzdmLabel.text = gynrDsrxxModel.sfzjhm;
        self.lxdzLabel.text = gynrDsrxxModel.jtdz;
    } else if ([gynrDsrxxModel.lxmc isEqualToString:@"法人组织"]){
        self.ygbgNameLabel.text = gynrDsrxxModel.mc;
        self.zzdmOrSfzhmLabel.text = @"证件号码:";
        self.lxdzOrZzmcLabel.text = @"组织名称:";
        self.zzdmLabel.text = gynrDsrxxModel.sfzjhm;
        self.lxdzLabel.text = gynrDsrxxModel.zzmc;
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
