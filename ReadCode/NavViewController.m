//
//  NavViewController.m
//  ReadCode
//
//  Created by enli on 2018/10/18.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//参考: https://blog.csdn.net/zhaotao0617/article/details/51131038
//1.如果只有ViewController的话,shouldAutorotate,一定会走的.
//2.但是关键是我们项目都是navigationController,shouldAutorotate方法就不会走了.属于方法被navigationController拦截了.这样就需要在你的navigationController基类添加以下代码:
//3.但是我发现ViewController里的shouldAutorotate还是不执行,我分析了一下,还是被拦截了,原因是我们项目都有tabbarController,也会被这个拦截掉.所以在你的tabbarController的基类里边添加如下代码:
//4.最后别忘记在你的ViewController里边添加这个代码:shouldAutorotate

-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.topViewController.supportedInterfaceOrientations;
}

/**以下两个方法可不写*/

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//        return UIInterfaceOrientationMaskAll;
//}
//
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//        returnUIInterfaceOrientationLandscapeRight;
//}

@end
