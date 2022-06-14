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
- (IBAction)menuAction:(id)sender {
    MenuViewController *menu = [[MenuViewController alloc] init];
    
    self.slideManager = [[NENSlideManager alloc] initWithMenuController:menu mainController:self transitionType:SlideTransitionTypeModal];
    self.slideManager.MenuWidth = 270;
    self.slideManager.targetEdge = UIRectEdgeLeft;
    self.slideManager.needBlur = YES;
    [self presentViewController:menu animated:YES completion:nil];
}


- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
    NSLog(@"unwindSegue %@", sender);
}

@end
