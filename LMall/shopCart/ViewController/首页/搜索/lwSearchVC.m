//
//  lwSearchVC.m
//  shopCart
//
//  Created by lw on 16/4/14.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwSearchVC.h"

@interface lwSearchVC ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate
>

{
    
    __weak IBOutlet UITextField *searchTxtFiled;
    __weak IBOutlet UITableView *myTableView;
}

@end

@implementation lwSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView.delegate = self;
    myTableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    searchTxtFiled.placeholder = _searchStr;
    searchTxtFiled.delegate = self;
    searchTxtFiled.returnKeyType = UIReturnKeySearch;
    [searchTxtFiled becomeFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%@",textField.placeholder);
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"您的搜索记录";
    
    return cell;
}

@end
