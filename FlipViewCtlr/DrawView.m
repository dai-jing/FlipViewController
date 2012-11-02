#import "DrawView.h"


@implementation DrawView

- (void) awakeFromNib
{
    curveList = [[NSMutableArray alloc] initWithCapacity: 10];
    curveColorList = [[NSMutableArray alloc] initWithCapacity: 10];
    circleList = [[NSMutableArray alloc] initWithCapacity: 10];
    circleColorList = [[NSMutableArray alloc] initWithCapacity: 10];
    rectList = [[NSMutableArray alloc] initWithCapacity: 10];
    rectColorList = [[NSMutableArray alloc] initWithCapacity: 10];
    hasMoved = NO;
    self.lineWidth = 1;
    self.redValue = 0;
    self.greenValue = 0;
    self.blueValue = 0;
    self.drawL = YES;
    self.drawC = NO;
    self.drawR = NO;
}

- (void) drawRect:(CGRect) rect 
{
    if (self.drawL)
    {
        [[UIColor colorWithRed: self.redValue green: self.greenValue blue: self.redValue alpha: 1] set];
        [self.curPath stroke];
    }
    else if (self.drawC)
    {
        UIColor *color = [UIColor colorWithRed: self.redValue green: self.greenValue blue: self.blueValue alpha:1];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGSize shadowOffset = CGSizeMake(5, -10);
        CGContextSetShadow(context, shadowOffset, 10);
        CGRect rect = CGRectMake(self.currentPoint.x-15, self.currentPoint.y-15, 30, 30);
        [circleList addObject: [NSValue valueWithCGRect: rect]];
        [circleColorList addObject: color];
        CGContextSetRGBFillColor(context, self.redValue, self.greenValue, self.blueValue, 1);
        CGContextFillEllipseInRect(context, rect);
    }
    else if (self.drawR)
    {
        UIColor *color = [UIColor colorWithRed: self.redValue green: self.greenValue blue: self.blueValue alpha:1];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGSize shadowOffset = CGSizeMake(5, -10);
        CGContextSetShadow(context, shadowOffset, 10);
        CGRect rect = CGRectMake(self.currentPoint.x-15, self.currentPoint.y-15, 30, 30);
        [rectList addObject: [NSValue valueWithCGRect: rect]];
        [rectColorList addObject: color];
        CGContextSetRGBFillColor(context, self.redValue, self.greenValue, self.blueValue, 1);
        CGContextFillRect(context, CGRectMake(self.currentPoint.x-15, self.currentPoint.y-15, 30, 30));
    }

    for (int i = 0; i < [curveList count]; i++)
    {
        UIBezierPath *path = [curveList objectAtIndex: i];
        UIColor *currentColor = [curveColorList objectAtIndex: i];
        const CGFloat *components = CGColorGetComponents(currentColor.CGColor);
        [[UIColor colorWithRed: components[0]  green: components[1] blue: components[2] alpha: 1] set];
        [path performSelector: @selector(stroke)];
    }
    
    for (int i = 0; i < [circleList count]; i++)
    {
        CGRect rect;
        NSValue *rectValue = [circleList objectAtIndex: i];
        UIColor *currentColor = [circleColorList objectAtIndex: i];
        const CGFloat *components = CGColorGetComponents(currentColor.CGColor);
        [rectValue getValue: &rect];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGSize shadowOffset = CGSizeMake(5, -10);
        CGContextSetShadow(context, shadowOffset, 10);
        CGContextSetRGBFillColor(context, components[0], components[1], components[2], 1);
        CGContextFillEllipseInRect(context, rect);
    }
    
    for (int i = 0; i < [rectList count]; i++)
    {
        CGRect rect;
        NSValue *rectValue = [rectList objectAtIndex: i];
        UIColor *currentColor = [rectColorList objectAtIndex: i];
        const CGFloat *components = CGColorGetComponents(currentColor.CGColor);
        [rectValue getValue: &rect];
    
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGSize shadowOffset = CGSizeMake(5, -10);
        CGContextSetShadow(context, shadowOffset, 10);
        CGContextSetRGBFillColor(context, components[0], components[1], components[2], 1);
        CGContextFillRect(context, rect);
    }
}

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
//  NSLog(@"touchesBegan width: %f",self.lineWidth);
    if (self.drawL)
    {
        UITouch* touch = [[event touchesForView: self] anyObject];
        CGPoint pt = [touch locationInView: self];
        
        if ([touch tapCount] > 1) return;
        
        self.curPath = [UIBezierPath bezierPath];
        self.curPath.lineWidth = self.lineWidth;
        
        [self.curPath moveToPoint: pt];
        hasMoved = NO;
        
        [self setNeedsDisplay];
    }
}

- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event
{
    if (self.drawL)
    {
        UITouch* touch = [[event touchesForView: self] anyObject];
        CGPoint pt = [touch locationInView: self];
        
        if ([touch tapCount] > 1) return;
        
        [self.curPath addLineToPoint: pt];
        hasMoved = YES;
        
        [self setNeedsDisplay];
    }

}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{  
    if (self.drawL)
    {
        
        UITouch* touch = [[event touchesForView: self] anyObject];
        
        if ([touch tapCount] > 1) {
            NSLog(@"tapCount: %d",[touch tapCount]);
            if ([curveList count] > 0) [curveList removeLastObject];
            self.curPath = nil;
            [self setNeedsDisplay];
            return;
        }
        
        if (!hasMoved) {
            self.curPath = nil;
            return;
        }
        
        CGPoint pt = [touch locationInView: self];
        UIColor *color = [UIColor colorWithRed: self.redValue green: self.greenValue blue: self.blueValue alpha: 1];
        [self.curPath addLineToPoint: pt];
        [curveList addObject: self.curPath];
        [curveColorList addObject: color];
        self.curPath = nil;
        
        [self setNeedsDisplay];
    }
    else if (self.drawC)
    {
        UITouch *touch = [[event touchesForView: self] anyObject];
        CGPoint pt = [touch locationInView: self];
        
        self.currentPoint = pt;
        [self setNeedsDisplay];

    }
    else if (self.drawR)
    {
        UITouch *touch = [[event touchesForView: self] anyObject];
        CGPoint pt = [touch locationInView: self];
        
        self.currentPoint = pt;
        [self setNeedsDisplay];
    }
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//  NSLog(@"touchesCancelled");
  
    self.curPath = nil;
}

- (void)dealloc
{
    [curveList release];
    [super dealloc];
}


@end
