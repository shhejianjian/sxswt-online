//
//  GYNewsTypeListModel.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYNewsTypeListModel : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, assign) NSInteger retCode;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *fydm;

@property (nonatomic, copy) NSString *dateColName;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, assign) BOOL activePage;

@property (nonatomic, assign) NSInteger end;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger sortno;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger pageSize;

@end
