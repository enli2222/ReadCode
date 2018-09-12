//
//  CodeViewController.m
//  ReadCode
//
//  Created by enli on 2018/9/12.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController (){
    NSString *_file;
    NSString *_path;
    UITextView *codeView;
}
@end

@implementation CodeViewController

-(instancetype)initWithfile:(NSString *)file path:(NSString *)path{
    if (self = [super init]) {
        _file = file;
        _path = path;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =_file;
    codeView = [[UITextView alloc]initWithFrame:self.view.bounds];
    NSAttributedString *txt = [[NSAttributedString alloc] initWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",_path,_file]] options:nil documentAttributes:nil error:nil];
    codeView.attributedText = txt;
    codeView.editable = NO;
    codeView.bounces = YES;
    [self.view addSubview:codeView];
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
