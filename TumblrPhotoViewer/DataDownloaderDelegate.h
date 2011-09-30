//
//  TextDownloadDelegate.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/29.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DataDownloaderDelegate)

-(void)downloading:(int)current of:(int)total;
-(void)downloadDidFinishWithText:(NSString *)str;
-(void)downloadDidFinishWithBinary:(NSData *)data;

@end
