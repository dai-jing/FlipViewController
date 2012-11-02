//
//  MainViewController.m
//  FlipViewCtlr
//
//  Created by Jing Dai on 9/30/12.
//  Copyright (c) 2012 Jing Dai. All rights reserved.
//

#import "MainViewController.h"

#import "DrawView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish: (FlipsideViewController *) flipCtlr
{
    theDrawView.lineWidth = flipCtlr.lineWidth;
    theDrawView.redValue = flipCtlr.redValue;
    theDrawView.greenValue = flipCtlr.greenValue;
    theDrawView.blueValue = flipCtlr.blueValue;
    theDrawView.drawL = flipCtlr.drawLine;
    theDrawView.drawC = flipCtlr.drawCircle;
    theDrawView.drawR = flipCtlr.drawRect;
  
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController * flipCtlr = [[[FlipsideViewController alloc] initWithNibName: @"FlipsideViewController" bundle: nil] autorelease];
    flipCtlr.delegate = self;
    flipCtlr.lineWidth = theDrawView.lineWidth;
    flipCtlr.redValue = theDrawView.redValue;
    flipCtlr.greenValue = theDrawView.greenValue;
    flipCtlr.blueValue = theDrawView.blueValue;
    flipCtlr.drawLine = theDrawView.drawL;
    flipCtlr.drawCircle = theDrawView.drawC;
    flipCtlr.drawRect = theDrawView.drawR;
    
    flipCtlr.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController: flipCtlr animated: YES completion: nil];
}

- (void) dealloc
{
  [super dealloc];
}

@end
