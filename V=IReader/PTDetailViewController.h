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
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UILabel *authorLbl;
@property (retain, nonatomic) IBOutlet UILabel *dateLbl;
@property (retain, nonatomic) IBOutlet UIWebView *contentWebView;

@end
