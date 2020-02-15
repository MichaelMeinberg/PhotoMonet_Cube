//
//  iCA_PhotoMonetCube_About_VC.m
//  PhotoMonet Cube
//
//  Created by Michael on 12/18/14.
//  Copyright (c) 2014 Michael. All rights reserved.
//

#import "iCA_PhotoMonetCube_About_VC.h"

@interface iCA_PhotoMonetCube_About_VC ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation iCA_PhotoMonetCube_About_VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *currentVersionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
           
    self.versionLabel.text =  [NSString stringWithFormat:@"Version: %@ (%@)",currentVersionNumber,build];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
