//
//  ELDownloader.h
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELDownloader : NSObject

-(instancetype)initWithURL:(NSString *)url;
-(void)suspend;
-(void)resume;

@end