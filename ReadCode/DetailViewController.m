//
//  DetailViewController.m
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "DetailViewController.h"
#import "ELFileNode.h"

@interface DetailViewController (){
    NSString *_path;
    UITableView *directories;
    NSMutableArray *_data;
}

@end

@implementation DetailViewController

-(NSArray *)createDemoData:(NSInteger)depth{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (int i=0; i < 4; i++) {
        ELFileNode *file = [[ELFileNode alloc]init];
        file.depth = depth +1;
        file.name = [NSString stringWithFormat:@"文件:%ld%d",file.depth,i];
        for (int i=0; i<file.depth; i++) {
            file.name = [NSString stringWithFormat:@"-%@",file.name];
        }
        file.expand = NO;
        [result addObject:file];
    }
    return result;
}

-(instancetype)initWithPach:(NSString *)path{
    if (self = [super init]) {
        _path = path;
        _data = [[NSMutableArray alloc]initWithArray: [self createDemoData:0]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    directories = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+200, self.view.bounds.size.width, self.view.bounds.size.height-200) style:UITableViewStylePlain];
    directories.delegate = self;
    directories.dataSource = self;
    directories.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:directories];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data count];
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
    if ([_data count] > indexPath.row) {
        ELFileNode *file =_data[indexPath.row];
        cell.textLabel.text = file.name;
    }else{
        cell.textLabel.text = @"错误节点";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELFileNode *parentNode = _data[indexPath.row];
    NSInteger startPosition = indexPath.row +1;
    BOOL expand = parentNode.expand;
    if (!expand) {
        NSArray *insertData = [self createDemoData:parentNode.depth];
        NSMutableArray *indexPathArray = [NSMutableArray array];
        for (int i=0; i < [insertData count]; i++) {
            ELFileNode *node =[insertData objectAtIndex:i];
            [_data insertObject:node atIndex:startPosition+i];
            NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:startPosition+i inSection:0];
            [indexPathArray addObject:tempIndexPath];
        }
        
        [directories insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        parentNode.expand = YES;
    }else{
//        [directories deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }
    
}


-(NSUInteger)removeAllNodesAtParentNode : (ELFileNode *)parentNode{
    NSUInteger startPosition = [_data indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_data.count; i++) {
        ELFileNode *node = [_data objectAtIndex:i];
        endPosition++;
        if (node.depth == parentNode.depth) {
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [_data removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
