//
//  AppDelegate.m
//  ReadCode
//
//  Created by 周鹏 on 2018/8/21.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface AppDelegate (){
    ViewController *vc;
    UINavigationController *nav;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    vc = [[ViewController alloc]init];
    nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = NO;
    nav.navigationBar.barStyle = UIBarStyleBlack;
    nav.navigationBar.topItem.title = @"代码库";
//    nav.hidesBarsOnTap = YES;
    nav.toolbarHidden = YES;
    nav.toolbar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd:)];
    nav.navigationBar.topItem.rightBarButtonItem = barButton;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
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
//        DetailViewController *dc = [[DetailViewController alloc]init];
//        [self->nav pushViewController:dc animated:YES];
    }];

    [alert addAction:cancelAction];
    [alert addAction:addAction];

    [nav presentViewController:alert animated:YES completion:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
