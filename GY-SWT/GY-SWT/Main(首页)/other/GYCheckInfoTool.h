//
//  GYCheckInfoTool.h
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYCheckInfoTool : NSObject
+ (BOOL)checkTelephone:(NSString *)telStr;
+ (BOOL)cardIDIsCorrect:(NSString *)IDNumber;
@end
