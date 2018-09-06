# NENSlideMenu

![NENSlideMenu](https://github.com/nenseso/NENSlideMenu/blob/master/1.gif)

* 使用

####CocoaPods
```
pod 'NENSlideMenu', '~> 1.0.1'
```
```
// 1.在主控制器中创建
NENSlideManager *slideManager = [[NENSlideManager alloc] initWithMenuController:destinationVC mainController:self];
// 2.确保它不是临时变量,因为转场的逻辑都统一由它来管理
self.slideManager = slideManager;
// 3.设置侧滑栏的初始位置
slideManager.targetEdge = UIRectEdgeLeft;
// 4.设置侧滑栏的宽度，如果不设置，默认是屏幕宽度
slideManager.MenuWidth = 270;
```
现在当我们执行presentViewController 即可modal出侧滑栏控制器。
