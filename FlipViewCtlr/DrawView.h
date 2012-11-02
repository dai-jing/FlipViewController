#import <UIKit/UIKit.h>


@interface DrawView : UIView {

    NSMutableArray *curveList;
    NSMutableArray *curveColorList;
    NSMutableArray *circleList;
    NSMutableArray *circleColorList;
    NSMutableArray *rectList;
    NSMutableArray *rectColorList;
    BOOL hasMoved;
  
}

@property (assign) CGPoint currentPoint;
@property (retain, nonatomic) UIBezierPath* curPath;
@property (assign) CGFloat lineWidth;
@property (assign) CGFloat redValue;
@property (assign) CGFloat greenValue;
@property (assign) CGFloat blueValue;
@property (assign) BOOL drawL;
@property (assign) BOOL drawC;
@property (assign) BOOL drawR;

@end
