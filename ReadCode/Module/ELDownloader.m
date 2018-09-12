//
//  ELDownloader.m
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELDownloader.h"
#import "AFNetworking.h"

typedef void(^EndBlock)(NSString *);

@interface ELDownloader(){
    NSURLSessionDownloadTask *_downloadTask;
    NSString * _url;
    EndBlock _endBlock;
}
@end

@implementation ELDownloader

-(instancetype)initWithURL:(NSString *)url end:(void (^)(NSString *dpath)) endBlock{
    if (self=[super init]) {
        _url = url;
        _endBlock = endBlock;
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
            NSString *dpath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            dpath = [NSString stringWithFormat:@"%@/projects",dpath];
             NSLog(@"%@",[filePath path]);
            if (![SSZipArchive unzipFileAtPath:[filePath path] toDestination:dpath delegate:self]) {
                NSLog(@"解压失败");
            }
        }
    }];
    
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath{
//    NSString *dpath = [NSString stringWithFormat:@"%@/%@",unzippedPath,[[path lastPathComponent] stringByDeletingPathExtension]];
//    NSLog(@"%@",dpath);
    if (self->_endBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_endBlock([[path lastPathComponent] stringByDeletingPathExtension]);
        });
    }
}

@end
