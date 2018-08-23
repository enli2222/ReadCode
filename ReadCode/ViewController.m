//
//  ViewController.m
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UITableView *tbList;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    tbList = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbList.delegate = self;
    tbList.dataSource = self;
    [self.view addSubview:tbList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 0.重用标识
    // 被static修饰的局部变量：只会初始化一次，在整个程序运行过程中，只有一份内存
    static NSString *ID = @"cell";
    
    // 1.先根据cell的标识去缓存池中查找可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果cell为nil（缓存池找不到对应的cell）
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 3.覆盖数据
    cell.textLabel.text = [NSString stringWithFormat:@"testdata - %zd", indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
