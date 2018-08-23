//
//  ELDownloader.m
//  ReadCode
//
//  Created by enli on 2018/8/22.
//  Copyright © 2018年 zpjoe. All rights reserved.
//

#import "ELDownloader.h"
#import "AFNetworking.h"

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
        NSLog(@"%@",path);
        return [NSURL fileURLWithPath:path];
//        /Users/enli/Library/Developer/CoreSimulator/Devices/A465F443-9E49-452F-B9B1-75B69AB63703/data/Containers/Data/Application/95CC448C-8ECB-4902-B5A3-868B7D6A15A7/Library/Caches/AudioRecognitionDemo-master.zip
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    
}

@end
