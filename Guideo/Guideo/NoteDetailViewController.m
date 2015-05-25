//
//  NoteDetailViewController.m
//  Guideo
//
//  Created by wei on 15/5/5.
//  Copyright (c) 2015年 Guideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteDetailViewController.h"
#import "ExpandHeader.h"
#import "ImageScaler.h"
#import "DataTransfer.h"


@interface NoteDetailViewController () <UIScrollViewDelegate>

@end

@implementation NoteDetailViewController
{
    ExpandHeader *_header;
    __weak IBOutlet UITextView *_textView;
    __weak UIImageView *_expandView;
}

@synthesize text, image;
@synthesize imageCache, imageDownloadingQueue;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    
    //self.title = topicName;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    CGSize newSize = CGSizeMake(self.view.frame.size.width, 180);
    if([image isEqualToString:@"null"])
    {
        [imageView setImage:[ImageScaler imageResize:[UIImage imageNamed:@"default.jpg"] andResizeTo:newSize]];
    }
    else
    {
        NSString *imageUrlString = image;
        
        UIImage *cachedImage = [self.imageCache objectForKey:imageUrlString];
        if (cachedImage) {
            imageView.image = cachedImage;
        } else {
            // you'll want to initialize the image with some blank image as a placeholder
            
            imageView.image = [ImageScaler imageResize:[UIImage imageNamed:@"image1.jpg"] andResizeTo:newSize];
            
            // now download in the image in the background
            
            [self.imageDownloadingQueue addOperationWithBlock:^{
                
                NSURL *imageUrl   = [NSURL URLWithString:imageUrlString];
                NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                UIImage *image1    = nil;
                if (imageData)
                    image1 = [ImageScaler imageResize:[UIImage imageWithData:imageData] andResizeTo:newSize];
                else
                    image1 = [ImageScaler imageResize:[UIImage imageNamed:@"default.jpg"] andResizeTo:newSize];
                
                if (image1) {
                    
                    [self.imageCache setObject:image1 forKey:imageUrlString];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        [imageView setImage:image1];
                    }];
                }
            }];
        }
    
        
    }
    
    _header = [ExpandHeader expandWithScrollView:_textView expandView:imageView];
    
    _textView.text = text;
    _textView.editable = NO;
    
}

@end