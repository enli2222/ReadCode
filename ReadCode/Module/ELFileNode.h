//
//  ELFileNode.h
//  ReadCode
//
//  Created by enli on 2018/8/24.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELFileNode : NSObject

@property (nonatomic,strong)NSString *path;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,assign)NSInteger depth;
@property (nonatomic,assign)BOOL expand;

@end
