//
//  ELProject.m
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELProject.h"

@implementation ELProject

@synthesize name=_name;
@synthesize url=_url;
@synthesize path=_path;
@synthesize flag=_flag;

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _url = [aDecoder decodeObjectForKey:@"url"];
        _path = [aDecoder decodeObjectForKey:@"path"];
        _flag = [aDecoder decodeObjectForKey:@"flag"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_url forKey:@"url"];
    [aCoder encodeObject:_path forKey:@"address"];
    [aCoder encodeInteger:_flag forKey:@"flag"];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%@",_name,_url,_path];
}

@end
