//
//  GYPeopleContactVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/14.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYPeopleContactVC.h"
#import "MXConstant.h"
#import "GYBmllModel.h"
#import "GYPCDetailCell.h"

static NSString *ID=@"GYPCDetailCell";

@interface GYPeopleContactVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *bmllStreetArr;
@property (nonatomic, strong) NSMutableArray *bmllListArr;
@property (strong, nonatomic) IBOutlet UIView *detailTableView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation GYPeopleContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
    self.backBtn.layer.cornerRadius = 15;
    self.backBtn.layer.masksToBounds = YES;
    self.detailTableView.layer.cornerRadius = 5;
    self.detailTableView.layer.masksToBounds = YES;
    
    NSString *fyjc = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_fyjc"];
    self.mxNavigationItem.title = [NSString stringWithFormat:@"%@-便民联络",fyjc];
    
    [self loadData];
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"GYPCDetailCell" bundle:nil] forCellReuseIdentifier:ID];
    
    
    
    // Do any additional setup after loading the view from its nib.
}





- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = courtDm;
    [GYHttpTool post:bmll_ListInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYBmllModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYBmllModel *bmllModel in arr) {
            [self.bmllStreetArr addObject:bmllModel.jzmc];
        }
        [self loadButtonWithArray:self.bmllStreetArr];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadButtonWithArray:(NSArray *)arr{
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 10;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = bottonBackgroundColor;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        
        CGFloat length = [arr[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 15 , 30);
        //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
        if(10 + w + length + 15 > KScreenW-20){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self.detailView addSubview:button];
    }
}


- (void)handleClick:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    self.detailView.hidden = YES;
    self.detailTableView.hidden = NO;
    [self loadDetailDataWithName:btn.titleLabel.text];
}
- (IBAction)backBtnClick:(id)sender {
    self.detailTableView.hidden = YES;
    self.detailView.hidden = NO;
}
- (void)loadDetailDataWithName:(NSString *)streetName {
    [self.bmllListArr removeAllObjects];
    [MBProgressHUD showMessage:@"正在加载" toView:self.view];
    NSString *courtDm = [[NSUserDefaults standardUserDefaults]objectForKey:@"chooseCourt_dm"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"fydm"] = courtDm;
    [GYHttpTool post:bmll_ListInfoUrl ticket:@"" params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *arr = [GYBmllModel mj_objectArrayWithKeyValuesArray:json[@"parameters"][@"rows"]];
        for (GYBmllModel *bmllModel in arr) {
            if ([streetName isEqualToString:bmllModel.jzmc]) {
                [self.bmllListArr addObject:bmllModel];
            }
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.bmllListArr.count;
    
}


- (GYPCDetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYPCDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYPCDetailCell alloc]init];
        
    }
    cell.bmllDetailModel = self.bmllListArr[indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 80;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYBmllModel *bmllModel = self.bmllListArr[indexPath.row];
    NSLog(@"%@",bmllModel.sj);
    if (bmllModel.sj) {
        [self callPhoneWithPhoneNumber:bmllModel.sj];
    }
}


- (void)callPhoneWithPhoneNumber:(NSString *)phoneNumber{
    NSString *message = [NSString stringWithFormat:@"确认拨打此电话？Tel:%@",phoneNumber];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (NSMutableArray *)bmllStreetArr {
	if(_bmllStreetArr == nil) {
		_bmllStreetArr = [[NSMutableArray alloc] init];
	}
	return _bmllStreetArr;
}

- (NSMutableArray *)bmllListArr {
	if(_bmllListArr == nil) {
		_bmllListArr = [[NSMutableArray alloc] init];
	}
	return _bmllListArr;
}

@end
