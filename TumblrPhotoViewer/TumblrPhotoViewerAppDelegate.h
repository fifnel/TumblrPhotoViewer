//
//  TumblrPhotoViewerAppDelegate.h
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TumblrPhotoViewerViewController;

@interface TumblrPhotoViewerAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TumblrPhotoViewerViewController *viewController;

@end
