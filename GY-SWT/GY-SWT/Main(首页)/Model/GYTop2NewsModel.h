//
//  GYTop2NewsModel.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYTop2NewsModel : NSObject

@property (nonatomic, assign) NSInteger sortno;

@property (nonatomic, assign) NSInteger retCode;

@property (nonatomic, copy) NSString *realContent;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, copy) NSString *createuserid;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger tj;

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger newstype;

@property (nonatomic, copy) NSString *imageurl;

@property (nonatomic, assign) BOOL activePage;

@property (nonatomic, copy) NSString *endDate;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, copy) NSString *pubdate;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *systime;

@property (nonatomic, copy) NSString *createusername;

@property (nonatomic, copy) NSString *newstypeid;

@property (nonatomic, copy) NSString *dateColName;

@property (nonatomic, assign) NSInteger end;

@property (nonatomic, copy) NSString *fydm;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, strong) NSArray<NSNumber *> *content;

@end
