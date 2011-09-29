//
//  TextDownload.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/29.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextDownloadDelegate.h"

@interface TextDownload : NSObject
{
@private
    NSURLConnection *m_conn;
    NSMutableData *m_data;
    int m_total_length;
    int m_current_length;
    
    NSObject *m_delegate;
}

-(void)start:(NSString *)url delegate:(NSObject *)delegate;
-(void)abort;


@end
