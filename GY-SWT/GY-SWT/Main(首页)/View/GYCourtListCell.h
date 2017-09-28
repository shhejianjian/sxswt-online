//
//  GYCourtListCell.h
//  GY-SWT
//
//  Created by 何键键 on 17/8/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYCourtListModel.h"

@protocol  GYCourtListCellDelegate <NSObject>

- (void)ChooseCourtWithBtnTag:(NSInteger )index;

@end

@interface GYCourtListCell : UITableViewCell
@property (nonatomic, strong) GYCourtListModel *courtListModel;
@property (strong, nonatomic) IBOutlet UIButton *setCourtBtn;

@property (nonatomic, weak) id <GYCourtListCellDelegate> delegate;

@end
