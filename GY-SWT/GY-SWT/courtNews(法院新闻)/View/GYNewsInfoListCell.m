//
//  GYNewsInfoListCell.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNewsInfoListCell.h"
#import "UIImageView+WebCache.h"

@interface GYNewsInfoListCell ()
@property (strong, nonatomic) IBOutlet UILabel *titelLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleLabelConstraint;

@end

@implementation GYNewsInfoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setNewsInfoListModel:(GYNewsInfoListModel *)newsInfoListModel {
    _newsInfoListModel = newsInfoListModel;
    self.titelLabel.text = newsInfoListModel.title;
    self.timeLabel.text = newsInfoListModel.pubdate;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.imageFileUrl,newsInfoListModel.imageurl]]placeholderImage:[UIImage imageNamed:@"加载"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }];
    
    if (newsInfoListModel.newstype == 3 && [newsInfoListModel.newstypeid isEqualToString:@"4"]) {
        self.myImageView.hidden = NO;
        self.titleLabelConstraint.constant = 110;
    } else {
        self.myImageView.hidden = YES;
        self.titleLabelConstraint.constant = 8;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
