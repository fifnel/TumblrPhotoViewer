//
//  XmlDownloadViewController.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XmlDownloadViewController : UIViewController {
    
@private
    NSURLConnection *m_conn;
    NSMutableData *m_data;
    int m_total_length;
    int m_current_length;
}

-(void)start:(NSString *)url;
-(void)downloading:(int)current of:(int)total;
-(void)downloadDidFinish:(NSString *)str;
-(void)abort;

@end
