//
//  GYSCZXDetailFourthVC.m
//  GY-SWT
//
//  Created by 何键键 on 17/2/23.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYSCZXDetailFourthVC.h"
#import "MXConstant.h"
#import "GYZxFourthCell.h"

static NSString *ID=@"GYZxFourthCell";



@interface GYSCZXDetailFourthVC ()
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation GYSCZXDetailFourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.cornerRadius = 5;
    self.detailView.layer.masksToBounds = YES;
     [self.myTableView registerNib:[UINib nibWithNibName:@"GYZxFourthCell" bundle:nil] forCellReuseIdentifier:ID];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return 1;
    
}


- (GYZxFourthCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    GYZxFourthCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell=[[GYZxFourthCell alloc]init];
        
    }
    cell.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 135;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}




@end
