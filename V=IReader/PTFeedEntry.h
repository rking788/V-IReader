//
//  PTFeedEntry.h
//  V=IReader
//
//  Created by Rob King on 1/11/12.
//  Copyright (c) 2012 University of Maine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTFeedEntry : NSObject{

    // Values in each of the JSON Entry fields
    NSString* _title;
    NSString* _author;
    NSString* _link;
    NSString* _content;
    NSString* _contentSnippet;
    NSString* _publishedDateStr;
    NSDate* _publishedDate;
    NSArray* _categories;
    UIImage* _previewImage;
}

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* link;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* contentSnippet;
@property (strong, nonatomic) NSString* publishedDateStr;
@property (strong, nonatomic) NSDate* publishedDate;
@property (strong, nonatomic) NSArray* categories;
@property (strong, nonatomic) UIImage* previewImage;

- (id) initWithJSONEntry: (NSDictionary*) jsonEntry;
- (NSString*) findImgUrl: (NSString*) entryContents;
- (UIImage*) cropPreviewImage: (NSString*) imgSrc;

@end
