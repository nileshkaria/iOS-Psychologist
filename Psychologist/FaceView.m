//
//  FaceView.m
//  Happiness
//
//  Created by Nilesh Karia on Jul/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

@synthesize dataSource = _dataSource;
@synthesize scale      = _scale;


#define DEFAULT_SCALE 0.90

- (CGFloat) scale
{
    if(!_scale)
        return DEFAULT_SCALE;
    else
        return _scale;
}

- (void) setScale:(CGFloat)scale
{
    //NOTE - setNeedsDisplay is expensive.
    //So check if scale is not resetting to itself.
    if(scale != _scale)
    {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (void) pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) ||
       (gesture.state == UIGestureRecognizerStateEnded))
    {
        self.scale *= gesture.scale;
        
        //We must compare to last scale on next pinch.
        //So set the gesture scale to 1.
        gesture.scale = 1;
    }
}

//NOTE - This sequence of setup and awakeFromNib need to be done to 
//redraw on autorotation. Since redraw: cannot be called directly,
//we must make the call from awakeFromNib
- (void) setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib
{
    [self setup];
}

//NOTE code in if()
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) 
    {
        [self setup];
    }
    
    return self;
}

- (void) drawCircleAtPoint:(CGPoint)p 
                withRadius:(CGFloat)radius 
                 inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw face - One circle
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width/2;
    
    if(self.bounds.size.height < self.bounds.size.width)
        size = self.bounds.size.height/2;
    
    size *= self.scale;
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    //Draw eyes - Two circles
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
    
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;

    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];
    eyePoint.x += size * EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];

    //No nose

    //Draw mouth
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - size * MOUTH_H;
    mouthStart.y = midPoint.y + size * MOUTH_V;
    
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += size * MOUTH_H * 2;
    
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += size * MOUTH_H * 2/3;
    
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= size * MOUTH_H * 2/3;
    
    float smile = [self.dataSource smileForFaceView:self];
    
    if(smile < -1)
        smile = -1;
    else if(smile > 1)
        smile = 1;
    
    CGFloat smileOffset = size * MOUTH_SMILE * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    
    CGContextStrokePath(context);
}

@end
