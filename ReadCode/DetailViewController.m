//
//  DetailViewController.m
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "DetailViewController.h"
#import "CodeViewController.h"
#import "ELFileNode.h"

@interface DetailViewController (){
    ELProject *_project;
    UITableView *directories;
    NSMutableArray *_data;
    UITextView *topPlan;
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

-(NSMutableArray *)getThroughAllatPath:(NSString *)path depth:(NSInteger)depth{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:path error:&error];
    BOOL isDir = NO;
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSString *file in fileList) {
        NSString *subpath = [path stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:subpath isDirectory:(&isDir)];
        ELFileNode *node = [[ELFileNode alloc]init];
        node.path = path;
        node.name = file;
        node.depth = depth +1;
        node.expand = NO;
        if (isDir) {
            node.type = 0;  //目录
        }else{
            node.type = 1;  //文件
        }
        isDir = NO;
        [result addObject:node];
    }
    return result;
    
}

-(instancetype)initWithProject:(ELProject *)project{
    if (self = [super init]) {
        _project = project;
        NSString *dpath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        dpath = [NSString stringWithFormat:@"%@/projects/%@",dpath,_project.path];
        _data = [self getThroughAllatPath:dpath depth:0];
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
    if (_project) {
        self.navigationItem.title = _project.title;
        topPlan = [[UITextView alloc]initWithFrame:CGRectMake(2,self.navigationController.navigationBar.frame.size.height+30,  self.view.bounds.size.width-4, 170-self.navigationController.navigationBar.frame.size.height)];
        topPlan.text = [NSString stringWithFormat:@"项目:%@\r\nURL:%@\r\n目录:%@",_project.title,_project.url,_project.path];
        topPlan.textAlignment = NSTextAlignmentLeft;
        topPlan.layer.borderColor = [UIColor blackColor].CGColor;
        topPlan.layer.borderWidth = 1;
        topPlan.layer.cornerRadius = 5;
        topPlan.editable = NO;
        [self.view addSubview:topPlan];
    }
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
            cell.textLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    }
    // 3.覆盖数据
    if ([_data count] > indexPath.row) {
        ELFileNode *file =_data[indexPath.row];
        NSString *title =file.name;
        if (file.type == 0) {
            title = [NSString stringWithFormat:@"\U0000eac6%@",title];
        }else{
            title = [NSString stringWithFormat:@"\U0000eac5%@",title];
        }
        for (int i=0; i<file.depth; i++) {
            title = [NSString stringWithFormat:@"  %@",title];
        }
        cell.textLabel.text = title;
    }else{
        cell.textLabel.text = @"错误节点";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ELFileNode *parentNode = _data[indexPath.row];
    NSInteger startPosition = indexPath.row + 1;
    BOOL expand = parentNode.expand;
    if (parentNode.type == 0) {
        if (!expand) {
            NSArray *insertData = [self getThroughAllatPath: [NSString stringWithFormat:@"%@/%@", parentNode.path,parentNode.name] depth:parentNode.depth];
            NSMutableArray *indexPathArray = [NSMutableArray array];
            for (int i=0; i < [insertData count]; i++) {
                ELFileNode *node =[insertData objectAtIndex:i];
                [_data insertObject:node atIndex:startPosition+i];
                NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:startPosition+i inSection:0];
                [indexPathArray addObject:tempIndexPath];
            }
            
            [directories insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
            parentNode.expand = YES;
        }
    }else{
        CodeViewController *cvc = [[CodeViewController alloc] initWithfile:parentNode.name path:parentNode.path];
        [self.navigationController pushViewController:cvc animated:YES];
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

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
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
