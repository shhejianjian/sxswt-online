//
//  SWTHttpTool.h
//  SX-SWT
//
//  Created by 何键键 on 16/7/27.
//  Copyright © 2016年 SWT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GYHttpTool : NSObject


+ (void)get:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure;
+ (void)post:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure;
+ (void)postImage:(NSString *)url ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure;
+ (void)uploadImage:(NSString *)url andImageData:(NSData *)image ticket:(NSString *)ticket params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error)) failure;
@end
