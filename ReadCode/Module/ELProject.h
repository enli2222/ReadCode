//
//  ELProject.h
//  ReadCode
//
//  Created by enli on 2018/8/27.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELProject : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NSString *flag;

+(NSMutableArray *)getlist;
-(instancetype)initWithID:(NSString *)ID;
-(void)save;
-(void)del;

@end
