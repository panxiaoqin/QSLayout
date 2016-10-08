# 欢迎使用QSLayout #
**QSLayout**是我写的专门做iOS布局使用的主要参考了Masonry的代码思路当然我写的没有他那么强大的功能呢

### 我写这个主要是解决以下问题： ###
1.如果我使用iOS自带的布局如xib和storyboard上布局如果在在代码上使用Masonry修改控件的大小则会出现警告

2.使用xib布局的使用可能需要线条分割如果使用Autolayout是无法设置大小小于1的(如果你希望在iPhone显示1px的线条)

3.在UIView+QSLayout添加的额外扩展可以在xib中设置边框，还有添加点击事件、设置扩展属性(在UITextField的Padding用的到)、移除控件


### 我写的目的及过程： ###

我早期使用的xib布局当时只有iPhone4一种大小，后来iPhone5出了我改用代码进行布局直接使用根据屏幕的高度计算出控件高度，之后接触了一下Masonry使用它的布局方式感觉很不错，我后来发现如果直接使用代码进行布局虽然可以使用循环添加控件，但是写代码的速度比不上拖控件的速度，所以我重新使用了xib进行布局，但是使用Autolayout如果需要在代码中动态修改控件的大小是个问题，不过也是可以使用xib把NSLayoutConstraint绑定到代码进行修改但终究比较麻烦，之后我想到能否使用UIView拿到NSLayoutConstraint进行修改，我后来就用UIView的constraints、removeConstraint、addConstraint进行操作，之后为了方便直接写出了QSLayout。QSLayout没有swift版本我在swift1.0和swift2.0的时候是是有swift的但由于swift3.0改动过大所以我转回OC就没有写swift版本。

### 示例： ###
假设parentView为父控件

    UIView *view = [[UIView alloc] init];
    [parentView addSubview:view];
    [view setQSLayout:^(QSLayoutMake *make) {
    	make.left.equal(parentView).offset(0);
    	make.top.equal(parentView).offset(10);
    	make.width.offset(200);
		make.height.offset(100);
    }];

这段代码是设置一个宽为200高为100距离父控件左边为0距离父控件顶部为0

    [view setQSLayout:^(QSLayoutMake *make) {
        make.width.remove();
        make.right.equal(parentView).offset(-20).multiplied(0.5);
    }];

这段代码是移除控件的宽度同时设置控件距离右边框为20但这个20是指父控件总宽度除以2后的边框就是父控件的中间线

    [view setQSLayout:^(QSLayoutMake *make) {
        make.center.equal(parentView).offset(100);
        make.size(CGSizeMake(100, 100));
    }];

这段代码是设置控件的偏离父控件的中心点x，y都是100同时是个宽高都有100的正方形

    [view setQSLayout:^(QSLayoutMake *make) {
        make.edge(UIEdgeInsetsMake(0, 0, 0, 0)).equal(parentView).multiplied(0.5);
    }];

这段代码是设置控件为父控件1/4大小

*以下假设在界面上有一个控件为test_view*

    [view setQSLayout:^(QSLayoutMake *make) {
        make.bottom.equal(test_view).top.offset(-10);
        make.left.equal(test_view).right.offset(10);
        make.width.equal(test_view).width.multiplied(2);
        make.height.offset(50);
    }];

这段代码是设置控件距离test_view顶部和右边为10,宽度为test_view的2倍，高度为50

    view.height = 100;
    view.width = 200;

如果觉得上面的代码的过于复杂可以使用上面的的代码设置宽高该代码如果在没有Autolayout下设置是直接更改UIView的frame属性

    view.width = 500;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.0f];
    [UIView setAnimationDuration:1.0f];
    [parentView layoutIfNeeded];
    [UIView commitAnimations];

这段代码可以将view的宽度通过动画的形式改到500

### 当前存在的问题： ###
在viewDidLoad方法中可以添加控件的时候使用QSLayout如果是修改xib的界面上的控件是不可以的因为这个时候UIView的constraints数组为空所以无法修改如果想修改可以将NSLayoutConstraint绑定到代码上修改

在viewDidAppear中或之后的方法就可以完整的使用QSLayout

### 反馈与建议： ###
由于我能力有限所以写出来的代码不一定是完美的如果你多我的代码有更好的建议，请一定告知我或发一份你修改的代码到我的邮箱。

邮箱：1025466161@qq.com