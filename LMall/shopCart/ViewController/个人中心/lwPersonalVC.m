//
//  lwPersonalVC.m
//  shopCart
//
//  Created by 刘威 on 16/4/23.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwPersonalVC.h"

@interface lwPersonalVC ()
<
    UITableViewDataSource,UITableViewDelegate
>
{
    UITableView *myTableView;
    NSMutableArray *dataArray;
}

@end

@implementation lwPersonalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self setupView];
}

- (void)initDataSource{
    dataArray = [NSMutableArray new];
    dataArray = [NSMutableArray arrayWithObjects:@"商家后台",@"用户后台", nil];
}

- (void)setupView{
    myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[lwEntity entitySingleton].lwPersonalCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[lwEntity entitySingleton].lwPersonalCellID];
    }
    
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",dataArray[2]);
}

@end








