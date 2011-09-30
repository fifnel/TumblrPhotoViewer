//
//  UIAsyncImageView.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/30.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataDownloader.h"

@interface UIAsyncImageView : UIImageView
{
    @private
    DataDownloader *m_downloader;
}

- (void)loadImage:(NSString *)url;

@end
