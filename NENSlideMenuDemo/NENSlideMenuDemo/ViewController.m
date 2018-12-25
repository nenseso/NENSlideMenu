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
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destinationVC = segue.destinationViewController;
    // create a gloable instance of the slideManager.
    self.slideManager = [[NENSlideManager alloc] initWithMenuController:destinationVC mainController:self transitionType:SlideTransitionTypePush];
    // set the menu width or height
//    self.slideManager.MenuHeight = 600;
    self.slideManager.MenuWidth = 270;
    // set the menu entry of the screen
//    self.slideManager.targetEdge = UIRectEdgeBottom;
//    self.slideManager.menuRadius = 16;
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
    NSLog(@"unwindSegue %@", sender);
}

@end
