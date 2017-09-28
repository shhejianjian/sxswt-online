//
//  GYGuideListModel.h
//  GY-SWT
//
//  Created by 何键键 on 17/8/25.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYGuideListModel : NSObject

@property (nonatomic, assign) NSInteger objecttype;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, copy) NSString *startDate;

@property (nonatomic, assign) NSInteger typeid;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *filepath;

@property (nonatomic, copy) NSString *sfyx;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, assign) NSInteger pxh;

@property (nonatomic, copy) NSString *createddate;

@property (nonatomic, copy) NSString *fbxt;

@property (nonatomic, copy) NSString *realContent;

@property (nonatomic, assign) NSInteger lb;

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, copy) NSString *lbmc;

@property (nonatomic, copy) NSString *fbrq;

@property (nonatomic, copy) NSString *retMsg;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger retCode;

@property (nonatomic, assign) NSInteger end;

@property (nonatomic, assign) BOOL activePage;

@property (nonatomic, copy) NSString *fydm;

@property (nonatomic, assign) NSInteger views;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger isdel;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) NSArray *content;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, copy) NSString *htmpath;

@property (nonatomic, copy) NSString *fymc;

@property (nonatomic, assign) NSInteger objectid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger hospitalid;

@property (nonatomic, assign) NSInteger sqlServec;

@property (nonatomic, copy) NSString *docpath;

@property (nonatomic, copy) NSString *dateColName;

@property (nonatomic, copy) NSString *endDate;

@end
