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
@synthesize link = _link;
@synthesize content = _content;
@synthesize contentSnippet = _contentSnippet;
@synthesize publishedDate = _publishedDate;
@synthesize categories = _categories;

- (id) initWithJSONEntry: (NSDictionary*) jsonEntry
{
    self = [super init];
   
    if(self){
        self.title = [jsonEntry objectForKey: @"title"];
        self.link = [jsonEntry objectForKey: @"link"];
        self.content = [jsonEntry objectForKey: @"content"];
        self.contentSnippet = [jsonEntry objectForKey: @"contentSnippet"];
        NSString* dateStr = [jsonEntry objectForKey: @"publishedDate"];
        //_publishedDate = [jsonEntry valueForKey: @"publishedDate"];
        self.categories = [jsonEntry objectForKey: @"categories"];
    }
    
    return self;
}

- (void)dealloc {
    [_title release];
    [_link release];
    [_content release];
    [_contentSnippet release];
    [_publishedDate release];
    [_categories release];
    [super dealloc];
}

@end
