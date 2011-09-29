//
//  TextDownload.m
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/29.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import "DataDownloader.h"

@implementation DataDownloader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [m_conn cancel];
    [m_conn release];
    [m_data release];
    
    [super dealloc];
}

-(void)start:(NSString *)url delegate:(NSObject *)delegate;
{
    [self abort];
    
    m_delegate = delegate;
    
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
    m_delegate = nil;
}

//--------------------------------------------
#pragma mark -- NSURLConnectionDelegate --
//--------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [m_data setLength:0];
    m_total_length = [response expectedContentLength];
    
    if ([m_delegate respondsToSelector:@selector(downloading:of:)]) {
        [m_delegate downloading:[m_data length] of:m_total_length];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    [m_data appendData:data];
    
    if ([m_delegate respondsToSelector:@selector(downloading:of:)]) {
        [m_delegate downloading:[m_data length] of:m_total_length];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    [self abort];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");

    if ([m_delegate respondsToSelector:@selector(downloadDidFinishWithText:)]) {
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
        [m_delegate downloadDidFinishWithText:data_str];
    }
    
    if ([m_delegate respondsToSelector:@selector(downloadDidFinishWithBinary:)]) {
        [m_delegate downloadDidFinishWithBinary:m_data];
    }

    [self abort];
}

@end
