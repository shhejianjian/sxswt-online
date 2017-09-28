//
//  GYImageNewsCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYImageNewsCell.h"
#import "UIImageView+WebCache.h"

@interface GYImageNewsCell ()

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@end

@implementation GYImageNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageNewsModel:(GYImageNewsModel *)imageNewsModel {
    _imageNewsModel = imageNewsModel;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://1.85.16.50:8082/upload/%@",imageNewsModel.imageurl]]placeholderImage:[UIImage imageNamed:@"加载"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
