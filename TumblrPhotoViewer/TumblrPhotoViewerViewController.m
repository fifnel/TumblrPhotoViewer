//
//  TumblrPhotoViewerViewController.m
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import "TumblrPhotoViewerViewController.h"

#import "GDataXMLNode.h"

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
    downloader = [[[DataDownloader alloc]init]autorelease];
    [downloader start:@"http://api.flickr.com/services/feeds/photos_public.gne?tags=%E4%BA%8C%E9%83%8E&lang=en-us&format=rss_200" delegate:self];
    [DownloadProgress setProgress:0.0f]; 
}

- (void)downloading:(int)current of:(int)total
{
    if (total>0) {
        [DownloadProgress setProgress:(current/total)];
    }
}

- (void)downloadDidFinishWithText:(NSString *)str
{
    // parse text as xml
	NSError* error;
	GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithXMLString:str options:0 error:&error];
	GDataXMLElement *rootNode = [document rootElement];
	
    // regist namespace
    NSMutableDictionary *ns = [[NSMutableDictionary alloc]init];
    [ns setValue:@"http://search.yahoo.com/mrss/" forKey:@"media"];

	// get thumbnails by xpath
	NSArray* userList = [rootNode nodesForXPath:@"//channel/item/media:thumbnail" namespaces:ns error:&error];
    NSMutableString *result = [[NSMutableString alloc]init];
	for(GDataXMLElement* node in userList) {
		NSLog(@"node:%@", [node stringValue]);
        [result appendString:[[node attributeForName:@"url"] stringValue]];
        [result appendString:@"\n"];
	}
	
	[document release];
    
    [TextView setText:(NSString *)result];
    [DownloadProgress setProgress:1.0f];
}

@end
