//
//  CodeViewController.m
//  ReadCode
//
//  Created by enli on 2018/9/12.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "CodeViewController.h"
#import "Masonry.h"
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
    
    NSMutableAttributedString *txt = [[NSMutableAttributedString alloc] initWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",_path,_file]] options:nil documentAttributes:nil error:nil];
    [txt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, txt.length)];
    codeView.attributedText = txt;
    codeView.editable = NO;
    codeView.bounces = YES;
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        }else{
            make.edges.equalTo(self.view);
        }
    }];
    if (@available(iOS 11.0, *)) {
        
        NSLog(@"codeView.bounds: X:%f Y:%f Width:%f Height:%f",codeView.bounds.origin.x
              ,codeView.bounds.origin.y,codeView.bounds.size.width,codeView.bounds.size.height);

        
    } else {
        // Fallback on earlier versions
    };
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
//    if (@available(iOS 11.0, *)) {
//        NSLog(@"viewSafeAreaInsetsDidChange X:%f Y:%f Width:%f Height:%f",self.view.safeAreaLayoutGuide.layoutFrame.origin.x
//              ,self.view.safeAreaLayoutGuide.layoutFrame.origin.y,self.view.safeAreaLayoutGuide.layoutFrame.size.width,self.view.safeAreaLayoutGuide.layoutFrame.size.height);
//        NSLog(@"viewSafeAreaInsetsDidChange 上:%f 下:%f 左:%f 右:%f",self.view.safeAreaInsets.top,self.view.safeAreaInsets.bottom,self.view.safeAreaInsets.left,self.view.safeAreaInsets.right);
//        NSLog(@"DidChange codeView.bounds: X:%f Y:%f Width:%f Height:%f",codeView.bounds.origin.x
//              ,codeView.bounds.origin.y,codeView.bounds.size.width,codeView.bounds.size.height);
//        NSLog(@"DidChange codeView.contentInset 上:%f 下:%f 左:%f 右:%f",codeView.contentInset.top,codeView.contentInset.bottom,codeView.contentInset.left,codeView.contentInset.right);
//    } else {
//        // Fallback on earlier versions
//    };
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
