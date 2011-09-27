//
//  XmlDownloadViewController.m
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/26.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import "XmlDownloadViewController.h"

@implementation XmlDownloadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)start:(NSString *)url
{
    [self abort];

    m_total_length = 0;
    m_data = [[NSMutableData alloc] initWithCapacity:0];
    NSURLRequest *req = [NSURLRequest
                         requestWithURL:[NSURL URLWithString:url]
                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                         timeoutInterval:30.0];
    m_conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
}

- (void)abort
{
	if(m_conn != nil){
		[m_conn cancel];
		[m_conn release];
		m_conn = nil;
	}
	if(m_data != nil){
		[m_data release];
		m_data = nil;
	}
    m_total_length = 0;
}

-(void)downloading:(int)current of:(int)total
{
    
}

-(void)downloadDidFinish:(NSString *)str
{
    
}

- (void)dealloc
{
    [m_conn cancel];
    [m_conn release];
    [m_data release];
    
    [super dealloc];
}

//--------------------------------------------
#pragma mark -- NSURLConnectionDelegate --
//--------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [m_data setLength:0];
    m_total_length = [response expectedContentLength];
    
    [self downloading:[m_data length] of:m_total_length];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    [m_data appendData:data];

    [self downloading:[m_data length] of:m_total_length];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    [self abort];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    int enc_arr[] = {
		NSUTF8StringEncoding,			// UTF-8
		NSShiftJISStringEncoding,		// Shift_JIS
		NSJapaneseEUCStringEncoding,	// EUC-JP
		NSISO2022JPStringEncoding,		// JIS
		NSUnicodeStringEncoding,		// Unicode
		NSASCIIStringEncoding			// ASCII
	};
	NSString *data_str = nil;
	int max = sizeof(enc_arr) / sizeof(enc_arr[0]);
	for (int i=0; i<max; i++) {
		data_str = [
                    [NSString alloc]
                    initWithData : m_data
                    encoding : enc_arr[i]
                    ];
		if (data_str!=nil) {
			break;
		}
	}

    [self downloadDidFinish:data_str];
    [self abort];
}

@end
