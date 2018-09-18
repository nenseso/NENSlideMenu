//
//  ViewController.m
//  NENSlideMenuDemo
//
//  Created by weuse_hao on 2018/9/4.
//  Copyright © 2018 weuse_hao. All rights reserved.
//

#import "ViewController.h"
#import <NENSlideManager.h>
#import "MenuViewController.h"
@interface ViewController ()
@property (nonatomic, strong) NENSlideManager *slideManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MenuViewController *menuVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MenuViewController"];
        NENSlideManager *slideManager = [[NENSlideManager alloc] initWithMenuController:menuVC mainController:self transitionType:SlideTransitionTypePush];
    self.slideManager = slideManager;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    UIViewController *destinationVC = segue.destinationViewController;

    // 确保它不是临时变量
    
//    slideManager.MenuWidth = 270;
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
    NSLog(@"unwindSegue %@", sender);
}

@end
