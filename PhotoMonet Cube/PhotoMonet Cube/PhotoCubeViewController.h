//
//  GameViewController.h
//  PhotoMonet Cube
//

//  Copyright (c) 2014 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

@interface PhotoCubeViewController : UIViewController
    @property (weak, nonatomic) IBOutlet SCNView *sceneView;
    @property (nonatomic, strong) NSMutableArray *images;
@end
