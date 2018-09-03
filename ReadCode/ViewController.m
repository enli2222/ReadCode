//
//  ViewController.m
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ViewController.h"
#import "ELProject.h"
#import "ELTableViewCell.h"

@interface ViewController (){
    UITableView *tbList;
    NSMutableArray *datalist;
}

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    datalist = [ELProject getlist];
    tbList = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbList.delegate = self;
    tbList.dataSource = self;
    tbList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tbList.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tbList];
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
        
        NSLog(@"name is %@, url is %@",name.text,url.text);
        ELProject *p = [[ELProject alloc] initWithID: [NSUUID UUID].UUIDString];
        p.title = name.text;
        p.url = url.text;
        [p save];
        self->datalist = [ELProject getlist];
        [self->tbList reloadData];
        //        [[[ELDownloader alloc]initWithURL:@"https://github.com/enli2222/AudioRecognitionDemo/archive/master.zip" end:^(NSString *dpath) {
        //            DetailViewController *dc = [[DetailViewController alloc]initWithPach:dpath];
        //            [self->nav pushViewController:dc animated:YES];
        //        }]resume];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    
    [self presentViewController:alert animated:NO completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datalist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    ELTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ELTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    ELProject *p = [[ELProject alloc]initWithID:datalist[indexPath.row]];
    cell.textLabel.text = p.title;
    cell.detailTextLabel.text = p.url;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
