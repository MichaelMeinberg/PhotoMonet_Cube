//
//  GameViewController.m
//  PhotoMonet Cube
//
//  Created by Michael on 12/13/14.
//  Copyright (c) 2014 Michael. All rights reserved.
//

#import "PhotoCubeViewController.h"
#import "CTMasterViewController.h"

@interface PhotoCubeViewController()
    @property (nonatomic, strong) SCNNode *geomertyNode;
    @property (nonatomic, strong) SCNNode  *boxNode;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *rotateButton;
    @property (nonatomic, strong) SCNAction *rotateAction;
    @property (nonatomic) BOOL rotating;
    @property (nonatomic) BOOL imagesFound;

    // Core Data
    @property (nonatomic,strong) NSManagedObjectContext *managedObjectContext; // Handle to the database - can't see the database without this
    @property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
    @property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end



@implementation PhotoCubeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sceneSetup];
    
//   // add a tap gesture recognizer
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    NSMutableArray *gestureRecognizers = [NSMutableArray array];
//    [gestureRecognizers addObject:tapGesture];
//    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
//    scnView.gestureRecognizers = gestureRecognizers;
}




#pragma mark Lazy Me


// Sets up Core Data database conneciton.
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}



-(NSMutableArray *)images
{
    if (! _images  ) _images  = [[NSMutableArray alloc] init];
    return _images  ;
}

-(SCNNode *)boxNode
{
    if (! _boxNode  ) _boxNode  = [[SCNNode alloc] init];
    return _boxNode  ;
}


-(SCNAction *)rotateAction
{
    if (! _rotateAction  ) _rotateAction  = [[SCNAction  alloc] init];
    return _rotateAction ;
}



#pragma mark General

#define PHOTO1NAME @"PhotoMonet Cube - Photo1"
#define PHOTO2NAME @"PhotoMonet Cube - Photo2"
#define PHOTO3NAME @"PhotoMonet Cube - Photo3"
#define PHOTO4NAME @"PhotoMonet Cube - Photo4"
#define PHOTO5NAME @"PhotoMonet Cube - Photo5"
#define PHOTO6NAME @"PhotoMonet Cube - Photo6"


-(void)loadCubePhotosFromCoreData
{
    
    
}
#pragma mark IBActions


- (IBAction)rotateCube:(UIBarButtonItem *)sender
{
    if (! self.rotating)
    {       self.rotating = YES;
        [self setCubeRotation];
        self.rotateButton.style = UIBarButtonSystemItemRewind;
    }
    else
    {
        self.rotating = NO;
        [self.boxNode removeAllActions];
        self.rotateButton.style = UIBarButtonSystemItemPlay;
    }
    
}



#pragma mark Game Methods

-(void)setCubeRotation
{
    self.rotating = YES;
    self.rotateAction = [SCNAction rotateByX:50 y:190 z:20 duration:1000.0];
    [SCNAction repeatActionForever:self.rotateAction];
    [self.boxNode runAction:self.rotateAction];
}




-(void)sceneSetup
{
    SCNScene *scene = [[SCNScene alloc] init];
    SCNBox *boxGeometry = [SCNBox boxWithWidth:10.0 height:10.0 length:10.0 chamferRadius:.50];
    self.boxNode = [SCNNode nodeWithGeometry:boxGeometry];
    [scene.rootNode addChildNode:self.boxNode];

    // Add Animation, make it move
    // [SCNTransaction setAnimationDuration:10.0];
    // boxNode.position = SCNVector3Make(5.0, -10.0, 4.0); // X, Y, Z
    // boxNode.opacity = 0.0;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int numberOfImages = [[defaults objectForKey:@"Number of Images"] intValue];

    if (numberOfImages == 0)
    {
        UIImage *pic1 = [UIImage imageNamed:@"Whale Tail 2.png"];
        UIImage *pic2 = [UIImage imageNamed:@"IMG_7627.JPG"];
        UIImage *pic3 = [UIImage imageNamed:@"IMG_0677.JPG"];
        UIImage *pic4 = [UIImage imageNamed:@"IMG_5004.JPG"];
        UIImage *pic5 = [UIImage imageNamed:@"IMG_6543.JPG"];
        UIImage *pic6 = [UIImage imageNamed:@"Peter and Michael.jpg"];
        
        self.images = [@[pic1,pic2,pic3,pic4,pic5,pic6] mutableCopy];
    }
    else
    {
        [self.images addObject:[self loadImageFromFile:PHOTO1NAME]];
        [self.images addObject:[self loadImageFromFile:PHOTO2NAME]];
        [self.images addObject:[self loadImageFromFile:PHOTO3NAME]];
        [self.images addObject:[self loadImageFromFile:PHOTO4NAME]];
        [self.images addObject:[self loadImageFromFile:PHOTO5NAME]];
        [self.images addObject:[self loadImageFromFile:PHOTO6NAME]];
    }
    
    SCNMaterial *photo1 = [self setPhoto:1];
    SCNMaterial *photo2 = [self setPhoto:2];
    SCNMaterial *photo3 = [self setPhoto:3];
    SCNMaterial *photo4 = [self setPhoto:4];
    SCNMaterial *photo5 = [self setPhoto:5];
    SCNMaterial *photo6 = [self setPhoto:6];
    
    boxGeometry.materials = @[photo1, photo2, photo3, photo4, photo5, photo6];
    
    self.geomertyNode = self.boxNode;
    
    self.sceneView.scene = scene;
    self.sceneView.autoenablesDefaultLighting = YES;
    self.sceneView.allowsCameraControl = YES;

    self.sceneView.backgroundColor = [UIColor blueColor];

    SCNNode *cameraNode = [[SCNNode alloc] init];
    cameraNode.camera = [[SCNCamera alloc] init];
    cameraNode.position = SCNVector3Make(0, 0, 25);

    [self setCubeRotation];

    [scene.rootNode addChildNode:cameraNode];
}



-(SCNMaterial *)setPhoto: (int)imageNumber
{
    SCNMaterial *photo = [[SCNMaterial alloc] init];
    if ([self.images count] > imageNumber-1)
        photo.diffuse.contents = self.images[imageNumber-1];
    else
        photo.diffuse.contents = [UIImage imageNamed:@"Blank Image.png"];
    
    return photo;
}



- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = (SCNView *)self.view;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0)
    {
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor redColor];
        
        [SCNTransaction commit];
    }
}



#pragma mark VC General orientation methods

- (BOOL)shouldAutorotate
{
    return YES;
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}





- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else
    {
        return UIInterfaceOrientationMaskAll;
    }
}



#pragma mark Save and Load image to the documents directory



-(UIImage *)loadImageFromFile: (NSString *)imageName
{
    NSData *pngData = [NSData dataWithContentsOfFile:[self documentsPathForFileName:imageName]];
    UIImage *image  = [UIImage imageWithData:pngData];
    
    if (! image)
    {
        image = [UIImage imageNamed:@"Blank Image.png"];
    }
    
    return image;
}


-(NSString *)saveImageToFile: (NSString *)imageName
                       image: (UIImage *)image
{
    NSData *pngData = UIImagePNGRepresentation(image); // This puts out PNG data of the image you've captured.
    
    //From here, you can write it to a file:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    // NSString *imageName = [NSString stringWithFormat:@"WanderlyPOI_Image_%@-%lu",[self getUserID], (unsigned long)self.poiID];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:imageName]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    return imageName;
}




#pragma mark  General methods

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Photos In Cube"])
    {
        NSLog(@"identifier: %@", segue.identifier);
      //  CTMasterViewController *descVC = segue.destinationViewController;
      //  descVC.images = self.images;
    }
    
}






@end



