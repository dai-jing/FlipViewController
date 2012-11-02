//
//  FlipsideViewController.h
//  FlipViewCtlr
//
//  Created by Steven Senger on 9/30/12.
//  Copyright (c) 2012 Steven Senger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController {
    IBOutlet UISlider *lineWidthSlider;
    IBOutlet UISlider *redSlider;
    IBOutlet UISlider *greenSlider;
    IBOutlet UISlider *blueSlider;
    IBOutlet UITextField *lineWidthField;
    IBOutlet UIButton *lineButton;
    IBOutlet UIButton *circleButton;
    IBOutlet UIButton *rectButton;
}

@property (assign, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (assign) float lineWidth;
@property (assign) CGFloat redValue;
@property (assign) CGFloat greenValue;
@property (assign) CGFloat blueValue;
@property (assign) BOOL drawLine;
@property (assign) BOOL drawCircle;
@property (assign) BOOL drawRect;

- (IBAction)takeLineWidthFrom: (UISlider *)aSlider;
- (IBAction)colorChanged: (UISlider *)colorSilder;
- (IBAction)buttonPressed: (UIButton *)button;

- (IBAction)done:(id)sender;

@end
