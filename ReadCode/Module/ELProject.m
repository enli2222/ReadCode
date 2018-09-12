//
//  ELProject.m
//  ReadCode
//
//  Created by enli on 2018/8/27.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#define LISTNAME @"projectlist"

#import "ELProject.h"
#import <objc/runtime.h>

@implementation ELProject

-(instancetype)initWithID:(NSString *)ID{
    if (self=[super init]) {
        _id = ID;
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:_id];
        if (dic) {
            u_int count;
            objc_property_t *properties  =class_copyPropertyList([self class], &count);
            for (int i = 0; i<count; i++)
            {
                const char* propertyName = property_getName(properties[i]);
                NSString *property = [NSString stringWithUTF8String: propertyName];
                [self setValue:[dic objectForKey:property] forKey:property];
            }
            free(properties);
        }
    }
    return self;
}

-(void)save{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        NSString *property = [NSString stringWithUTF8String: propertyName];
        NSString *value = [self valueForKey:property];
        if (value) {
            [dic setObject:value forKey:property];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:_id];
    NSMutableArray *list = [[self class] getlist];
    if ([list indexOfObject:_id]== NSNotFound ) {
        [list addObject:_id];
        [[NSUserDefaults standardUserDefaults] setObject:list forKey:LISTNAME];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    free(properties);
}

-(void)del{
    [[NSFileManager defaultManager] removeItemAtPath:_path error:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:_id];
    NSMutableArray *list = [[self class] getlist];
    if ([list indexOfObject:_id] != NSNotFound ) {
        [list removeObject:_id];
        [[NSUserDefaults standardUserDefaults] setObject:list forKey:LISTNAME];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSMutableArray *)getlist{
    NSMutableArray *list = [[NSUserDefaults standardUserDefaults] objectForKey:LISTNAME];
    if (!list) {
        list = [[NSMutableArray alloc]init];
    }else{
        list = [[NSMutableArray alloc]initWithArray:list];
    }
    return list;
}

@end
