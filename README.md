# NENSlideMenu

![NENSlideMenu](https://github.com/nenseso/NENSlideMenu/blob/master/1.gif)
![NENSlideMenu](https://github.com/nenseso/NENSlideMenu/blob/master/2.gif)

NENSlideMenu is a smiple transition controller to help you to modal or push a menu controller.

## Requirements

- iOS 8.0 or later

## Usage

####CocoaPods
```
pod 'NENSlideMenu'
```
```
// 1.Create it in main controller,ensure it is a global instance
self.slideManager = [[NENSlideManager alloc] initWithMenuController:destinationVC mainController:self transitionType:SlideTransitionTypeModal];
// 3.set the menu entry
self.slideManager.targetEdge = UIRectEdgeLeft;
// self.slideManager.targetEdge = UIRectEdgeBottom;
// 4.set the menu width or height, default is screen width or height
self.slideManager.MenuWidth = 270;
// self.slideManager.MenuHeight = 600;
```
>  Warning
NENSlideMenu will take a strong reference to presented controller, so it can't be dealloc after it is dismissed. 
