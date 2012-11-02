//
//  MainViewController.h
//  FlipViewCtlr
//
//  Created by Steven Senger on 9/30/12.
//  Copyright (c) 2012 Steven Senger. All rights reserved.
//

#import "FlipsideViewController.h"

@class DrawView;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
  IBOutlet DrawView * theDrawView;
}

- (IBAction)showInfo:(id)sender;

@end
