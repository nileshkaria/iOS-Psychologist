//
//  FaceView.h
//  Happiness
//
//  Created by Nilesh Karia on Jul/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//Forward declarations
@class FaceView;

@protocol FaceViewDataSource

//@NOTE - Pass yourself along as the sender when writing delegates
//to transfer information 
- (float) smileForFaceView:(FaceView *)sender;

@end

@interface FaceView : UIView

@property (nonatomic) CGFloat scale;

- (void) pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;

@end
