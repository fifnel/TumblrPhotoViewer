//
//  TumblrPhotoViewerViewController.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XmlDownloadViewController.h"

@interface TumblrPhotoViewerViewController : XmlDownloadViewController {
    UIToolbar *RefreshButton;
    UIScrollView *ImageListView;
    UIProgressView *DownloadProgress;
    IBOutlet UITextView *TextView;
}

@property (nonatomic, retain) IBOutlet UIToolbar *RefreshButton;
@property (nonatomic, retain) IBOutlet UIScrollView *ImageListView;
@property (nonatomic, retain) IBOutlet UIProgressView *DownloadProgress;

- (IBAction)onRefresh:(id)sender;
@end
