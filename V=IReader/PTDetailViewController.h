//
//  PTDetailViewController.h
//  V=IReader
//
//  Created by Rob King on 1/11/12.
//  Copyright (c) 2012 University of Maine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTFeedEntry;

@interface PTDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) PTFeedEntry* detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
