//
//  ELProject.h
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELProject : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) BOOL flag;  //YES 已下载  NO 未下载

@end
