//
//  ELMessage.m
//  ReadCode
//
//  Created by enli on 2018/9/25.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELMessage.h"

@implementation ELMessage

+(void)show:(NSString *)msg title:(NSString *)title present:(UIViewController *)present{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok");
    }];
    [alert addAction:ok];
    [present presentViewController:alert animated:NO completion:nil];
}

@end
