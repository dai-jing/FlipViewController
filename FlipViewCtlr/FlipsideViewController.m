//
//  FlipsideViewController.m
//  FlipViewCtlr
//
//  Created by Jing Dai on 9/30/12.
//  Copyright (c) 2012 Jing Dai. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
  
    lineWidthField.text = [NSString stringWithFormat: @"%lf", self.lineWidth];
    lineWidthSlider.value = self.lineWidth;
    
    [redSlider setValue: self.redValue];
    [greenSlider setValue: self.greenValue];
    [blueSlider setValue: self.blueValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction) takeLineWidthFrom: (UISlider *) sender
{
    self.lineWidth = sender.value;
    lineWidthField.text = [NSString stringWithFormat: @"%f", self.lineWidth];
}

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)colorChanged:(UISlider *)colorSilder
{
    self.redValue = [redSlider value];
    self.greenValue = [greenSlider value];
    self.blueValue = [blueSlider value];
}

- (IBAction)buttonPressed:(UIButton *)button
{
    if (button == lineButton)
    {
        self.drawLine = YES;
        self.drawCircle = NO;
        self.drawRect = NO;
    }
    else if (button == circleButton)
    {
        self.drawCircle = YES;
        self.drawLine = NO;
        self.drawRect = NO;
    }
    else if (button == rectButton)
    {
        self.drawRect = YES;
        self.drawLine = NO;
        self.drawCircle = NO;
    }
}

@end
