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
}
@end

@implementation ELDownloader

-(void)getZip:(NSString *)url{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    _downloadTask = [manager downloadTaskWithRequest:request
                                           progress:nil
                                        destination:nil
                                  completionHandler:nil];
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//
//    }];
//
    
}

@end
