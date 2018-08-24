//
//  ELDownloader.m
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELDownloader.h"
#import "AFNetworking.h"
#import "ZipArchive.h"

@interface ELDownloader(){
    NSURLSessionDownloadTask *_downloadTask;
    NSString * _url;
}
@end

@implementation ELDownloader

-(instancetype)initWithURL:(NSString *)url{
    if (self=[super init]) {
        _url = url;
    }
    return self;
}

-(void)suspend{
    if (_downloadTask) {
        [_downloadTask suspend];
    }
}
-(void)resume{
    if (!_downloadTask) {
        [self createTask];
    }
    [_downloadTask resume];
    
}

-(void)createTask{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f%%",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error.description);
        }else{
            NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
             NSLog(@"%@",[filePath path]);
            if (![SSZipArchive unzipFileAtPath:[filePath path] toDestination:path]) {
                NSLog(@"解压失败");
            }
            
        }
    }];
    
}

@end
