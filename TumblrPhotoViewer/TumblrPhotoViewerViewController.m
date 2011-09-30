//
//  TumblrPhotoViewerViewController.m
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import "TumblrPhotoViewerViewController.h"

#import "GDataXMLNode.h"
#import "UIAsyncImageView.h"

@implementation TumblrPhotoViewerViewController
@synthesize MainView;
@synthesize RefreshButton;
@synthesize DownloadProgress;
@synthesize TextView;
@synthesize ImageListview;

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
    [TextView release];
    TextView = nil;
    [self setDownloadProgress:nil];
    [self setMainView:nil];
    [self setTextView:nil];
    [self setImageListview:nil];
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
    [TextView release];
    [DownloadProgress release];
    [MainView release];
    [TextView release];
    [ImageListview release];
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
    int i=0;
    float height=100.0f;
    float width=320.0/3.0f;
	for(GDataXMLElement* node in userList) {
		NSLog(@"node:%@", [node stringValue]);

        NSString *thumburl = [NSString stringWithString:[[node attributeForName:@"url"] stringValue]];
        UIAsyncImageView *image = [[UIAsyncImageView alloc]initWithFrame:CGRectMake(i%3*width, i/3*height,width,height)];
        [image loadImage:thumburl];
        [ImageListview addSubview:image];
        [image release];    

        i++;
        
        // for debug
        [result appendString:[[node attributeForName:@"url"] stringValue]];
        [result appendString:@"\n"];
	}
    [ImageListview setContentSize:CGSizeMake(320, i/3*height+height)];
	
	[document release];
    
    [TextView setText:(NSString *)result];
    [DownloadProgress setProgress:1.0f];
}

@end
