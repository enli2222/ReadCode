//
//  ViewController.m
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "ELTableViewCell.h"
#import "ELMessage.h"

@interface ViewController (){
    UITableView *tbList;
    NSMutableArray *datalist;
    NSInteger indexOpenCell;
    UIActivityIndicatorView * activityIndicator;
}

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    datalist = [ELProject getlist];
    indexOpenCell = -1;
    tbList = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbList.delegate = self;
    tbList.dataSource = self;
    tbList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tbList.backgroundColor = [UIColor grayColor];
    tbList.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbList.estimatedRowHeight = 0;
    tbList.estimatedSectionFooterHeight = 0;
    tbList.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:tbList];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    [self.view addSubview:activityIndicator];
    //设置小菊花的frame
    activityIndicator.frame= self.view.bounds;
    //设置小菊花颜色
    activityIndicator.color = [UIColor yellowColor];
    //设置背景颜色
    activityIndicator.backgroundColor = [UIColor clearColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    activityIndicator.hidesWhenStopped = YES;
}

-(IBAction)onAdd:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增" message:@"请输入名称和URL地址" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"项目描述";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"项目URL地址";
        //        textField.secureTextEntry = YES;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"新增" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *name = alert.textFields.firstObject;
        UITextField *url= alert.textFields.lastObject;
        if ([name.text isEqualToString:@""]) {
            [ELMessage show:@"项目描述不能为空!!" title:@"警告" present:self.navigationController];
            return;
        }
        if ([url.text isEqualToString:@""]) {
            [ELMessage show:@"项目URL不能为空!!" title:@"警告" present:self.navigationController];
            return;
        }
        NSLog(@"name is %@, url is %@",name.text,url.text);
        ELProject *p = [[ELProject alloc] initWithID: [NSUUID UUID].UUIDString];
        p.title = name.text;
        p.url = url.text;
        [p save];
        self->datalist = [ELProject getlist];
        [self->tbList reloadData];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    
    [self presentViewController:alert animated:NO completion:nil];
}

-(IBAction)onDeleteClick:(id)sender{
    if (indexOpenCell > -1 && indexOpenCell < [datalist count]) {
        ELProject *p = [[ELProject alloc]initWithID:datalist[indexOpenCell]];
        [p del];
        datalist = [ELProject getlist];
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:indexOpenCell inSection:0];
        NSArray *indexPathArray = @[tempIndexPath];
//        [indexPathArray addObject:tempIndexPath];
        [tbList deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(IBAction)onReloadClick:(id)sender{
    if (indexOpenCell > -1 && indexOpenCell < [datalist count]) {
        ELProject *p = [[ELProject alloc]initWithID:datalist[indexOpenCell]];
        if (p.url && [p.url length] > 0) {
            [activityIndicator startAnimating];
            [[[ELDownloader alloc]initWithURL:p.url end:^(NSString *dpath) {
                p.path = dpath;
                [p save];
                [self->activityIndicator stopAnimating];
                DetailViewController *dc = [[DetailViewController alloc]initWithProject:p];
                [self.navigationController pushViewController:dc animated:YES];
            }]resume];
        }
    }

}

-(IBAction)onDetailClick:(id)sender{
    if (indexOpenCell > -1 && indexOpenCell < [datalist count]) {
        ELProject *p = [[ELProject alloc]initWithID:datalist[indexOpenCell]];
        if (p.path && [p.path length] > 0) {
            DetailViewController *dc = [[DetailViewController alloc]initWithProject:p];
            [self.navigationController pushViewController:dc animated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datalist count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ELTableViewCell getCellHeight:(indexPath.row == indexOpenCell)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    ELTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELTableViewCell alloc] initWithController:self reuseIdentifier:ID];
    }
    ELProject *p = [[ELProject alloc]initWithID:datalist[indexPath.row]];
    cell.project = p;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSTimeInterval duration = 0.0;
    if (indexOpenCell == indexPath.row) {
        indexOpenCell = -1;
        duration = 0.5;
    }else{
        indexOpenCell = indexPath.row;
        duration = 0.5;
    }
    ELTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell unfold:YES animated:YES completion:nil ];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    } completion:nil];
}

- (BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
