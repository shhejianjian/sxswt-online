//
//  GYAddNewCaseSeventhVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/27.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYAddNewCaseSeventhVC.h"
#import "MXConstant.h"
#import "GYNetRegistVC.h"
#import "GYwslaDetailCollCell.h"
#import "GYClxxModel.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"
#import "ZoomImageView.h"

NSString *checkSucessWsla;

@interface GYAddNewCaseSeventhVC ()<LDActionSheetDelegate,LDImagePickerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *stepView;
@property (strong, nonatomic) IBOutlet UIView *blackLineView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *imageDataArr;
@property (nonatomic, strong) NSMutableArray *clxxModelArr;

@end

@implementation GYAddNewCaseSeventhVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
- (void)setUI {
    self.mxNavigationItem.title = @"核对委托材料";
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.stepView.layer.cornerRadius = 2.5f;
    self.stepView.layer.masksToBounds = YES;
    self.blackLineView.layer.cornerRadius = 5;
    self.blackLineView.layer.masksToBounds = YES;
    
    self.nextBtn.layer.cornerRadius = 15;
    self.nextBtn.layer.masksToBounds = YES;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"GYwslaDetailCollCell"bundle:nil]forCellWithReuseIdentifier:@"collectionCellID"];
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.5;
    [self.myCollectionView addGestureRecognizer:longPressGr];
    
    [self loadWslaAjxxDetailInfoWithMlid];
    
}
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.myCollectionView];
        NSIndexPath * indexPath = [self.myCollectionView indexPathForItemAtPoint:point];
        if(indexPath == nil) return ;
        if (indexPath.row != self.imageDataArr.count) {
            GYClxxModel *clxxModel = self.clxxModelArr[indexPath.row];
            NSLog(@"indexpath:%ld",indexPath.row);
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"jlid"] = clxxModel.jlid;
            NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
            [GYHttpTool post:wsla_deletePhotoUrl ticket:ticket params:params success:^(id json) {
                NSLog(@"json:%@",json);
                GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
                if ([loginModel.success isEqualToString:@"true"]) {
                    [MBProgressHUD showSuccess:@"删除成功"];
                    [self loadWslaAjxxDetailInfoWithMlid];
                } else {
                    [MBProgressHUD showError:loginModel.msg];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
        
    }
}
- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
}

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    NSData *imageData = UIImageJPEGRepresentation(editedImage, 0.5);
    
    
    NSLog(@"editedImage:%@",editedImage);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"mlid"] = @"14";
    params[@"fydm"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool uploadImage:wsla_savePhotoUrl andImageData:imageData ticket:ticket params:params success:^(id json) {
        NSLog(@"uploadSuccess:%@",json);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            NSLog(@"success");
            [self loadWslaAjxxDetailInfoWithMlid];
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
    } failure:^(NSError *error) {
        
    }];
}



- (void)loadWslaAjxxDetailInfoWithMlid{
    [self.imageDataArr removeAllObjects];
    [self.clxxModelArr removeAllObjects];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = self.ajbsStr;
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"mlid"] = @"14";
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    [GYHttpTool post:wsla_ajxx_detailClxxInfoUrl ticket:ticket params:params success:^(id json) {
        NSLog(@"%@===+++===%@",json,params);
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            
            if ([loginModel.msg isEqualToString:@"当前没有信息"]) {
                [MBProgressHUD hideHUDForView:self.view];
                [self.myCollectionView reloadData];
//                [MBProgressHUD showSuccess:loginModel.msg];
            }
            NSArray *arr = [GYClxxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
            
            for (GYClxxModel *clxxModel in arr) {
                [self.clxxModelArr addObject:clxxModel];
                NSMutableDictionary *imageParams = [NSMutableDictionary dictionary];
                imageParams[@"jlid"] = clxxModel.jlid;
                [GYHttpTool postImage:wsla_ajxx_detailClxxImageInfoUrl ticket:ticket params:imageParams success:^(id json) {
                    [self.imageDataArr addObject:json];
                    [self.myCollectionView reloadData];
                    [MBProgressHUD hideHUDForView:self.view];
                } failure:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
            
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}


//有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageDataArr.count+1;
}


-(GYwslaDetailCollCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GYwslaDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellID" forIndexPath:indexPath];
    
    if (indexPath.row == self.imageDataArr.count) {
        cell.myImageView.image = [UIImage imageNamed:@"plus.png"];
    } else {
        UIImage *image = [UIImage imageWithData:self.imageDataArr[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.myImageView.image = image;
        });
    }
    
    return cell;
    
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(90, 116);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"+++%ld",(long)indexPath.row);
    GYwslaDetailCollCell *cell = (GYwslaDetailCollCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == self.imageDataArr.count) {
        NSLog(@"chooseImage");
        LDActionSheet *actionSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"从相册中选择", nil];
        [actionSheet showInView:self.view];
    } else {
        [[ZoomImageView getZoomImageView]showZoomImageView:cell.myImageView addGRType:0];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"长按小图可删除";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }
}

- (IBAction)nexBtnClick:(id)sender {
    
    if (self.imageDataArr.count == 0) {
        [MBProgressHUD showError:@"请先上传委托材料"];
    } else {
        [MBProgressHUD showMessage:@"正在提交申请" toView:self.view];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"ajbs"] = self.ajbsStr;
        NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
        [GYHttpTool post:wsla_ajxxtjUrl ticket:ticket params:params success:^(id json) {
            NSLog(@"json:::%@",json);
            GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
            if ([loginModel.success isEqualToString:@"true"]) {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:@"立案成功"];
                checkSucessWsla = @"success";
                [self jumpToVC];
            } else {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showError:loginModel.msg];
            }
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    
}
- (void)jumpToVC {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[GYNetRegistVC class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}

- (NSMutableArray *)imageDataArr {
	if(_imageDataArr == nil) {
		_imageDataArr = [[NSMutableArray alloc] init];
	}
	return _imageDataArr;
}

- (NSMutableArray *)clxxModelArr {
	if(_clxxModelArr == nil) {
		_clxxModelArr = [[NSMutableArray alloc] init];
	}
	return _clxxModelArr;
}

@end
