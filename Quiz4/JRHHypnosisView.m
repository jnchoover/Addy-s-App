//
//  JRHHypnosisView.m
//  Hypnosister4
//
//  Created by Jennifer Hoover on 3/13/14.
//  Copyright (c) 2014 Jennifer Hoover. All rights reserved.
//

#import "JRHHypnosisView.h"

@interface JRHHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end


@implementation JRHHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All JRHHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //The circle with be the largest that will fit in the view. It will be half of the smaller of the view's dimensions (either portrait or landscape depending on the phone position
    //float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    //Replace above with concentric circles. The largest circle witll circumstribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    //Use UIBezierPath for drawing lines and curves
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        
        //Pick up path and draw another circle...dont connect them
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    //Add an arc to the path at center, with radius of "radius" from 0 to 2*PI radians (a circle)
    //[path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    
    path.lineWidth = 10;
    
    //To set line color, you have to get and instance of UIColor and use the setStroke method of UIColor. UIColor has convenience methods so you don't need alloc init.
    //Set default color in initWithFrame
    //[[UIColor lightGrayColor] setStroke];
    [self.circleColor setStroke];
    
    //Draw the arc with the help from UIBezierPath method for drawing paths
    [path stroke];
    
}

//Override touchesBegan:withEvent. When a finger touches the screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    //Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    self.circleColor = randomColor;
                
}

//Implement a custom accessor for the circleColor property so that the view knows to change. Has to be sent manually (like below) in custom classes like JRHHypnosisView
-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}


@end
