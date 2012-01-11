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
    NSString* _link;
    NSString* _content;
    NSString* _contentSnippet;
    NSDate* _publishedDate;
    NSArray* _categories;
}

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* link;
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* contentSnippet;
@property (strong, nonatomic) NSDate* publishedDate;
@property (strong, nonatomic) NSArray* categories;

- (id) initWithJSONEntry: (NSDictionary*) jsonEntry;

@end
