//
//  GYNRDetailFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/13.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYNRDetailFourthVC.h"
#import "XFSegmentView.h"
#import "MXConstant.h"
#import "GYClxxModel.h"
#import "ZoomImageView.h"
#import "GYwslaDetailCollCell.h"



@interface GYNRDetailFourthVC ()<XFSegmentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    UIView *background;
}

@property (strong, nonatomic) IBOutlet UIView *detailView;
//@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageListArr;
@property (nonatomic, strong) NSMutableArray *imageDataArr;
@property (nonatomic, copy) NSString *mlidType;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@end

@implementation GYNRDetailFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    XFSegmentView *segView=[[XFSegmentView alloc]initWithFrame:Frame(0, 64, SCREEN_WIDTH, WH(40))];
    [self.view addSubview:segView];
    segView.delegate = self;
    segView.titles = @[@"起诉书",@"证件材料",@"委托材料"];
    segView.titleFont = Font(15);
    
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    
    [self loadWslaAjxxDetailInfoWithMlid:@"3"];
    
//    [[ZoomImageView getZoomImageView]showZoomImageView:self.myImageView addGRType:0];
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    self.myCollectionView = [UICollectionView alloc]ini
     [self.myCollectionView registerNib:[UINib nibWithNibName:@"GYwslaDetailCollCell"bundle:nil]forCellWithReuseIdentifier:@"collectionCellID"];
    
    // Do any additional setup after loading the view from its nib.
}


- (void)loadWslaAjxxDetailInfoWithMlid:(NSString *)mlid{
    [self.imageDataArr removeAllObjects];
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"ajbs"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"wsla_ajxx_ajbs"];
    params[@"page"] = @"1";
    params[@"pageSize"] = @"100";
    params[@"mlid"] = mlid;
    NSString *ticket = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_ticket"];
    
    [GYHttpTool post:wsla_ajxx_detailClxxInfoUrl ticket:ticket params:params success:^(id json) {
        GYLoginModel *loginModel = [GYLoginModel mj_objectWithKeyValues:json[@"parameters"]];
        if ([loginModel.success isEqualToString:@"true"]) {
            
            if ([loginModel.msg isEqualToString:@"当前没有信息"]) {
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:loginModel.msg];
                [self.myCollectionView reloadData];
            }
            
        } else {
            [MBProgressHUD showError:loginModel.msg];
        }
        NSArray *arr = [GYClxxModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYClxxModel *clxxModel in arr) {
            NSLog(@"++%@",clxxModel.jlid);
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
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不稳定，请稍后再试"];
    }];
}



//有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageDataArr.count;
}


-(GYwslaDetailCollCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GYwslaDetailCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellID" forIndexPath:indexPath];
    UIImage *image = [UIImage imageWithData:self.imageDataArr[indexPath.row]];
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.myImageView.image = image;
    });
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
    [[ZoomImageView getZoomImageView]showZoomImageView:cell.myImageView addGRType:0];
}


-(void)segmentView:(XFSegmentView *)segmentView didSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
            if (![self.mlidType isEqualToString:@"3"]) {
                [self loadWslaAjxxDetailInfoWithMlid:@"3"];
                self.mlidType = @"3";
            }
            break;
        case 1:
            if (![self.mlidType isEqualToString:@"8"]) {
                [self loadWslaAjxxDetailInfoWithMlid:@"8"];
                self.mlidType = @"8";
            }
            break;
        case 2:
            if (![self.mlidType isEqualToString:@"14"]) {
                [self loadWslaAjxxDetailInfoWithMlid:@"14"];
                self.mlidType = @"14";
            }
            break;
        default:
            break;
    }
}

- (NSMutableArray *)imageListArr {
    if(_imageListArr == nil) {
        _imageListArr = [[NSMutableArray alloc] init];
    }
    return _imageListArr;
}


- (NSMutableArray *)imageDataArr {
	if(_imageDataArr == nil) {
		_imageDataArr = [[NSMutableArray alloc] init];
	}
	return _imageDataArr;
}

@end
