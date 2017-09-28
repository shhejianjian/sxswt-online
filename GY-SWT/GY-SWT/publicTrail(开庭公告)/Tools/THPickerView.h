//
//  THPickerView.h
//  test
//
//  Created by 童浩 on 2017/1/6.
//  Copyright © 2017年 童小浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_cancelButtonColor [UIColor redColor] //取消按钮颜色
#define k_confirmButtonColor [UIColor redColor] //确定按钮颜色
#define k_confirmButtonNotClickColor [UIColor colorWithRed:205.0 / 255.0 green:205.0 / 255.0 blue:205.0 / 255.0 alpha:1]  //滑动时确认按钮不可点击颜色
@interface THPickerView : UIView
/*
 数据格式如递归取值的比如
 [
	{
        "name1":"A",
        "ID":001,
        "data1":
            [
                {
                    "name2":"A1",
                    "ID":003,
                    "data2":
                        [
                            {
                                "name3":"A1A",
                                "ID":006
                            }
                        ]
                },
                {
                    "name2":"A2",
                    "ID":005
                }
            ]
    },
	{
        "name1":"B",
        "ID":002,
        "data1":
            [
                {
                    "name2":"B1",
                    "ID":004
                }
            ]
	}
 ]
 这样的数据DataKeyArray 就是数据里对应的下一级级的Key 是个数组 0位是data1  1号位是data2 DataKeyArray就是@[@"data1",@"data2"]
 dataArray 就是数组数据
 而testKeyArray就是要显示的 数据里对应的下一级的testKey 是个数组 0位是name1 1号位是name2 2号位是name3 3级
 numberOfComponents 就是几层级 这里数据最多3级就是 3
 */
- (instancetype)initWithDataKeyArray:(NSArray<NSString *> *)keyArray AndDataArray:(NSArray *)dataArray AndTestKeyArray:(NSArray<NSString *> *)testKeyArray AndNumberOfComponents:(NSInteger)numberOfComponents;
/*
    数据格式如递归取值的比如
 [
	{
        "name":"A",
        "ID":001,
        "data":
            [
                {
                    "name":"A1",
                    "ID":003,
                    "data":
                        [
                            {
                                "name":"A1A",
                                "ID":006
                            }
                        ]
                },
                {
                    "name":"A2",
                    "ID":005
                }
            ]
	},
	{
        "name":"B",
        "ID":002,
        "data":
            [
                {
                    "name":"B1",
                    "ID":004
                }
            ]
	}
 ]
 
 这样的数据DataKey 就是数据里对应的二级的Key "data"
 dataArray 就是数组数据
 而testKey就是要显示的 数据里对应的 key "name"
 numberOfComponents 就是几层级 这里数据最多3级就是 3
*/
- (instancetype)initWithDataKey:(NSString *)key AndDataArray:(NSArray *)dataArray AndTestKey:(NSString *)testKey AndNumberOfComponents:(NSInteger)numberOfComponents;
//回调数组是几级分类的第几个 比如数组0位输出字符串2就代表第一排数据选中的是第二个 以此类推
- (void)showConfirmBlock:(void (^)(NSArray<NSString *> *indexArray))block;
@end
