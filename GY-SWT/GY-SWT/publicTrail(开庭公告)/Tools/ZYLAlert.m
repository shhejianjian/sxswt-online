//
//  ZYLAlert.m
//  ZYLAlertController
//
//  Created by zhuyuelong on 16/6/18.
//  Copyright © 2016年 zhuyuelong. All rights reserved.
//

#import "ZYLAlert.h"

#define iOS8_0 [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0


@interface ZYLAlert() <UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray *_arrayAlertTitle;
    NSMutableArray *_arrayAlertAction;
    
    NSMutableArray *_arraySheetTitle;
    NSMutableArray *_arraySheetAction;
}

//iOS8.0之后会使用UIAlertController，所以需要使用调用该类的ViewController
@property (nonatomic, weak) UIViewController *sender;

@end

@implementation ZYLAlert

//重写该方法，保证该对象不会被释放，如果被释放，iOS8以下的UIAlertView的回调时候会崩溃
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    static ZYLAlert *_shareAlertView = nil;
    dispatch_once(&onceToken, ^{
        if (_shareAlertView == nil) {
            _shareAlertView = [super allocWithZone:zone];
        }
    });
    return _shareAlertView;
}

- (instancetype)init
{
    if (self = [super init]) {
        _arrayAlertTitle = [NSMutableArray array];
        _arrayAlertAction = [NSMutableArray array];
        
        _arraySheetTitle = [NSMutableArray array];
        _arraySheetAction = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if ([self init]) {
        _title = title;
        _message = message;
    }
    return self;
}

- (void)setTitle:(NSString *)title message:(NSString *)message
{
    _title = title;
    _message = message;
}

- (void)addBtnAlertTitle:(NSString *)title action:(ClickAction)action
{
    [_arrayAlertTitle addObject:title];
    [_arrayAlertAction addObject:action];
}

- (void)addBtnSheetTitle:(NSString *)title action:(ClickAction)action
{
    [_arraySheetTitle addObject:title];
    [_arraySheetAction addObject:action];
}

- (void)showAlertWithSender:(UIViewController *)sender
{
    if (_arrayAlertTitle.count == 0) {
        return;
    }
    self.sender = sender;
    if (iOS8_0) {
        [self showAlertController];
    } else {
        [self showAlertView];
    }
}

- (void)showAlertController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < _arrayAlertTitle.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:_arrayAlertTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ClickAction ac = _arrayAlertAction[i];
            ac();
        }];
        [alert addAction:action];
    }
    if (_sender) {
        [_sender showDetailViewController:alert sender:nil];
    }
}

- (void)showAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    for (NSString *title in _arrayAlertTitle) {
        [alert addButtonWithTitle:title];
    }
    
    [alert show];
}

- (void)showActionSheetWithSender:(UIViewController *)sender
{
    if (_arraySheetTitle.count == 0) {
        return;
    }
    self.sender = sender;
    if (iOS8_0) {
        [self showActionSheetController];
    } else {
        [self showActionSheet];
    }
}

- (void)showActionSheetController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < _arraySheetTitle.count; i++) {
        
        if (i == _arraySheetTitle.count - 1) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:_arraySheetTitle[i] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                ClickAction ac = _arraySheetAction[i];
                ac();
            }];
            
            [alert addAction:action];
            
        }else{
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:_arraySheetTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ClickAction ac = _arraySheetAction[i];
                ac();
            }];
            
            [alert addAction:action];
            
        }
        
    }
    if (_sender) {
        [_sender showDetailViewController:alert sender:nil];
    }
}


- (void)showActionSheet
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:_title delegate:self cancelButtonTitle:nil destructiveButtonTitle:_message otherButtonTitles:nil, nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    for (NSString *title in _arraySheetTitle) {
        [actionSheet addButtonWithTitle:title];
    }
    
    [actionSheet showInView:self.sender.view];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    ClickAction action = _arrayAlertAction[buttonIndex];
    action();
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    ClickAction action = _arraySheetAction[buttonIndex];
    action();
    
}

#pragma - mark 用于传入title显示AlertView（只有确定按钮）,没点击事件
+ (void)showAlertViewCertainWithTitle:(NSString *)title WithUIViewController:(UIViewController *)ViewControll
{
    if (iOS8_0) {
        
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            
        }];
        
        [alertController addAction:otherAction];
        
        [ViewControll presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
    }
}




@end
