//
//  PTFeedEntry.m
//  V=IReader
//
//  Created by Rob King on 1/11/12.
//  Copyright (c) 2012 University of Maine. All rights reserved.
//

#import "PTFeedEntry.h"

@implementation PTFeedEntry

@synthesize title = _title;
@synthesize author = _author;
@synthesize link = _link;
@synthesize content = _content;
@synthesize contentSnippet = _contentSnippet;
@synthesize publishedDateStr = _publishedDateStr;
@synthesize publishedDate = _publishedDate;
@synthesize categories = _categories;
@synthesize previewImage = _previewImage;

// Sizes needed to crop the image to the table view cell
#define IV_WIDTH    320
#define IV_HEIGHT   60

- (id) initWithJSONEntry: (NSDictionary*) jsonEntry
{
    self = [super init];
   
    if(self){
        self.title = [jsonEntry objectForKey: @"title"];
        self.author = [jsonEntry objectForKey: @"author"];
        self.link = [jsonEntry objectForKey: @"link"];
        self.content = [jsonEntry objectForKey: @"content"];
        self.contentSnippet = [jsonEntry objectForKey: @"contentSnippet"];
        self.publishedDateStr = [jsonEntry objectForKey: @"publishedDate"];
        //_publishedDate = [jsonEntry valueForKey: @"publishedDate"];
        self.categories = [jsonEntry objectForKey: @"categories"];
        
        NSString* previewImageUrl = [self findImgUrl: self.content];
        self.previewImage = [self cropPreviewImage: previewImageUrl];
    }
    
    return self;
}

- (NSString*) findImgUrl: (NSString*) entryContents
{
    NSRange startImgRange = [entryContents rangeOfString: @"<img src="];
    NSString* trimmedStr = [entryContents substringFromIndex: (startImgRange.location + startImgRange.length)];
    
    NSString* imgsrcregex = @"http://[^\"]+";
    NSRange urlRange = [trimmedStr rangeOfString: imgsrcregex options:NSRegularExpressionSearch];
    
    
    // Set the weather image in the UIImageView
    NSString* imgSrcText = [trimmedStr substringWithRange: urlRange];
    
    return imgSrcText;
}

- (UIImage*) cropPreviewImage: (NSString*) imgSrc
{
    NSURL* url = [NSURL URLWithString: imgSrc];
    NSData* data = [NSData dataWithContentsOfURL: url];
    UIImage* img = [[UIImage alloc] initWithData: data];
    UIImage* croppedImg = img;
   
    // If the image is smaller than the image view then no cropping is necessary
    if((img.size.width > IV_WIDTH) || (img.size.height > IV_HEIGHT)){
        CGSize size = [img size];
        
        CGFloat croppedWidth;
        CGFloat croppedHeight;
        CGFloat startX;
        CGFloat startY;
        
        // To crop the image I decided to take a setion out of the center of the image
        // that is the size of the image view in the table view cells
        if(IV_WIDTH < size.width){
            croppedWidth = IV_WIDTH;
            startX = ((size.width / 2) - (IV_WIDTH / 2));
        }
        else{
            croppedWidth = size.width;
            startX = 0;
        }
        
        if(IV_HEIGHT < size.height){
            croppedHeight = IV_HEIGHT;
            startY = ((size.height / 2) - (IV_HEIGHT / 2));
        }
        else{
            croppedHeight = size.height;
            startY = 0;
        }
        
        CGRect smallRect = CGRectMake(startX,
                                      startY,
                                      croppedWidth,
                                      croppedHeight);
        CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], smallRect);
        croppedImg = [UIImage imageWithCGImage: imageRef];
        CGImageRelease( imageRef);
    }
    
    return croppedImg;
}

- (void)dealloc {
    [_title release];
    [_author release];
    [_link release];
    [_content release];
    [_contentSnippet release];
    [_publishedDateStr release];
    [_publishedDate release];
    [_categories release];
    [super dealloc];
}

@end
