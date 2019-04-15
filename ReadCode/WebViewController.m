//
//  WebViewController.m
//  ReadCode
//
//  Created by enli on 2019/4/10.
//  Copyright © 2019 zpjoe. All rights reserved.
//

#import "WebViewController.h"
#import "Masonry.h"

@interface WebViewController (){
    UIWebView *web;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"帮助";
    // Do any additional setup after loading the view.
    web = [[UIWebView alloc]init];
    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"help" ofType:@"html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];
    [web mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        }else{
            make.edges.equalTo(self.view);
        }
    }];
    
//    for (NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
    
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
