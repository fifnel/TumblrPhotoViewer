//
//  TumblrPhotoViewerViewController.m
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import "TumblrPhotoViewerViewController.h"

@implementation TumblrPhotoViewerViewController
@synthesize RefreshButton;
@synthesize ImageListView;
@synthesize DownloadProgress;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [DownloadProgress setProgress:0.0f]; 
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setRefreshButton:nil];
    [self setImageListView:nil];
    [TextView release];
    TextView = nil;
    [self setDownloadProgress:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [RefreshButton release];
    [ImageListView release];
    [TextView release];
    [DownloadProgress release];
    [super dealloc];
}

- (IBAction)onRefresh:(id)sender {
    downloader = [[[TextDownload alloc]init]autorelease];
    [downloader start:@"http://www.google.co.jp/" delegate:self];
    [DownloadProgress setProgress:0.0f]; 
}

- (void)downloading:(int)current of:(int)total
{
    if (total>0) {
        [DownloadProgress setProgress:(current/total)];
    }
}

- (void)downloadDidFinish:(NSString *)str
{
    [TextView setText:str];
    [DownloadProgress setProgress:1.0f];
}

@end
