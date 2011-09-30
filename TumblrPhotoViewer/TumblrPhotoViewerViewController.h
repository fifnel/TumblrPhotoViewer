//
//  TumblrPhotoViewerViewController.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDownloader.h"

@interface TumblrPhotoViewerViewController : UIViewController {
    DataDownloader *downloader;
    
    UIToolbar *RefreshButton;
    UIProgressView *DownloadProgress;
    UITextView *TextView;
    UIScrollView *ImageListview;
    UIScrollView *MainView;
}
@property (nonatomic, retain) IBOutlet UIScrollView *MainView;

@property (nonatomic, retain) IBOutlet UIToolbar *RefreshButton;
@property (nonatomic, retain) IBOutlet UIProgressView *DownloadProgress;
@property (nonatomic, retain) IBOutlet UITextView *TextView;

@property (nonatomic, retain) IBOutlet UIScrollView *ImageListview;
- (IBAction)onRefresh:(id)sender;
@end
