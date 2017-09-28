//
//  GYHomeCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYHomeCell.h"
#import "UIImageView+WebCache.h"
#import "MXConstant.h"
@interface GYHomeCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GYHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsModel:(GYTop2NewsModel *)newsModel {
    
    _newsModel = newsModel;
    self.titleLabel.text = newsModel.title;
    self.dateLabel.text = newsModel.pubdate;
    self.imageView.image = nil;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.imageFileUrl,newsModel.imageurl]]placeholderImage:[UIImage imageNamed:@"加载"]];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.imageFileUrl,newsModel.imageurl]]placeholderImage:[UIImage imageNamed:@"加载"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
////        self.imageView.contentMode = UIViewContentModeScaleToFill;
//    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
