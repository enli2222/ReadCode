//
//  ELDownloader.h
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"

@interface ELDownloader : NSObject<SSZipArchiveDelegate>

-(instancetype)initWithURL:(NSString *)url end:(void (^)(NSString *path)) endBlock;
-(void)suspend;
-(void)resume;

@end
