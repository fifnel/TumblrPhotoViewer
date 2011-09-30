//
//  UIAsyncImageView.m
//  TumblrPhotoViewer
//
//  Created by fifnel on 2011/09/30.
//  Copyright 2011年 fifnel. All rights reserved.
//

#import "UIAsyncImageView.h"

@implementation UIAsyncImageView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [m_downloader release];
    [super dealloc];
}

- (void)loadImage:(NSString *)url
{
    [m_downloader release];
    m_downloader = [[DataDownloader alloc]init];
    [m_downloader start:url delegate:self];
}

-(void)downloadDidFinishWithBinary:(NSData *)data
{
	self.contentMode = UIViewContentModeScaleAspectFit;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth || UIViewAutoresizingFlexibleHeight;		
    
	self.image = [UIImage imageWithData:data];    
}

@end
