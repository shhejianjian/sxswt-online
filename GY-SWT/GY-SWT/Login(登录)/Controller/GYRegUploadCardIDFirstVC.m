//
//  GYRegUploadCardIDFirstVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/24.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYRegUploadCardIDFirstVC.h"
#import "MXConstant.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"
#import "GYLoginVC.h"


@interface GYRegUploadCardIDFirstVC ()<LDActionSheetDelegate,LDImagePickerDelegate>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString *secondIdStr;
@property (nonatomic, copy) NSString *checkImage;

@end

@implementation GYRegUploadCardIDFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}


- (void)setUI {
    self.mxNavigationItem.title = @"上传身份证正面";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 20;
    self.nextBtn.layer.masksToBounds = YES;
    
    self.myImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage)];
    [self.myImageView addGestureRecognizer:tapGesturRecognizer];
}

- (void)chooseImage{
    NSLog(@"chooseImage");
    LDActionSheet *actionSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选择", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    self.myImageView.contentMode = UIViewContentModeScaleToFill;
    self.myImageView.image = editedImage;
    self.checkImage = @"choosed";
}

- (IBAction)nextClick:(UIButton *)sender {
    NSData *imageData = UIImageJPEGRepresentation(self.myImageView.image , 0.5);
    if ([sender.titleLabel.text isEqualToString:@"下一步"]) {
        if (self.checkImage) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"loginUserType"] = @"1";
            params[@"id"] = self.registIdStr;
            params[@"zplx"] = @"1";
            [GYHttpTool uploadImage:wsla_uploadPhotoUrl andImageData:imageData ticket:@"" params:params success:^(id json) {
                NSLog(@"json:%@",json);
                GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
                if ([loginModel.success isEqualToString:@"true"]) {
                    self.secondIdStr = loginModel.id;
                    [sender setTitle:@"完成" forState:UIControlStateNormal];
                    self.myImageView.contentMode = UIViewContentModeCenter;
                    self.myImageView.image = [UIImage imageNamed:@"灰色加号"];
                    self.checkImage = nil;
                    self.titleLabel.text = @"请上传身份证背面";
                } else {
                    [MBProgressHUD showError:loginModel.msg];
                }
            } failure:^(NSError *error) {
                NSLog(@"error:%@",error);
            }];
        } else {
            [MBProgressHUD showError:@"请上传身份证正面再进行下一步"];
        }
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"完成"]) {
        if (self.checkImage) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"loginUserType"] = @"1";
            params[@"id"] = self.secondIdStr;
            params[@"zplx"] = @"2";
            [GYHttpTool uploadImage:wsla_uploadPhotoUrl andImageData:imageData ticket:@"" params:params success:^(id json) {
                NSLog(@"json:%@",json);
                GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
                if ([loginModel.success isEqualToString:@"true"]) {
                    [MBProgressHUD showSuccess:@"注册成功"];
                    [self jumpToVC];
                    NSLog(@"完成");
                } else {
                    [MBProgressHUD showError:loginModel.msg];
                }
            } failure:^(NSError *error) {
                NSLog(@"error:%@",error);
            }];
        } else {
            [MBProgressHUD showError:@"请上传身份证背面再完成"];
        }
        return;
        
    }
    
}


- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[GYLoginVC class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}










@end
