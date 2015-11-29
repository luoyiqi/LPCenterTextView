# LPCenterTextView

##使用场景

![](https://github.com/hanshuaiLoopeer/LPCenterTextView/raw/master/Screenshorts/image1.png)

类似图中，时间、地点、性别、标签这样的多行文本，文本顺序不变，但是任意一行都可以缺失，这种场景非常常见，但是代码实现起来却很费功夫，且容易出错，布局更是容易冲突。

首先自定义view中要有一大坨成员变量：
```obj-c
@implementation SSActivityDetailInformationCell {
    UILabel *_nameLabel;
    UILabel *_addressLabel;
    UILabel *_timeLabel;
    UILabel *_sexLimitLabel;
    UILabel *_tagsLabel;
    UILabel *_moneyLabel;
    UIImageView *_addressImageView;
    UIImageView *_timeImageView;
    UIImageView *_sexLimitImageView;
    UIImageView *_tagsImageView;
    UIImageView *_moneyImageView;
}
```
然后写一排初始化方法，最麻烦的是布局。为了实现顺序不变，任意一行右可以缺失，比如有的数据没有sex，要把sex这一行隐藏，其他顺序不变，势必需要在布局中写`if - else`，不但容易引起`布局冲突`，更重要的是难以`维护`，比如这样：

```obj-c
[_moneyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (_tagsImageView.hidden) {
            make.top.equalTo(_sexLimitImageView.mas_bottom).offset(5);
        } else {
            make.top.equalTo(_tagsImageView.mas_bottom).offset(5);
        }
        
        make.width.mas_equalTo(_tagsImageView.image.size.width);
        make.height.mas_equalTo(_tagsImageView.image.size.height);
        make.left.equalTo(_addressImageView);
        
        if (!_moneyImageView.hidden) {
            make.bottom.equalTo(self.contentView).offset(-15);
        }
    }];
```

为解决以上问题，我写了这个LPCenterTextView
    LPCenterTextView有以下优点
      * 一个View，替代了上边的8个成员变量，降低代码复杂度
      * 布局去掉了大量的`if-else`，益于维护
      * 赋值时，不必判断数据是否为空，直接赋值，如果数据为空，对应的Label自动隐藏，如果所有数据为空，LPCenterTextView高度为0
      * view高度由内部决定，根据内容自适应高度


##Usage

初始化
```obj-c
    @implementation CenterTextViewController {
        LPCenterTextView *_infoView;
}
```
```obj-c
    _infoView = [[LPCenterTextView alloc] init];
    //设置View内所有Label的属性
    _infoView.numberOfLine = 0;
    _infoView.contentFont = [UIFont systemFontOfSize:14];
    _infoView.contentColor = [UIColor lightGrayColor];
    //设置特定Label的属性
    [_infoView setTextColor:[UIColor blackColor] InIndex:0];
    [self.view addSubview:_infoView];
```
赋值，直接给所有的Label赋值，如果值为nil,该Label会自动隐藏，最后需要 refresh，来更新view。

不带图片的纯文本
```obj-c
      [_contentTextView setText:[connectionModel connectsDisplayFullName] forLabel:0];
      [_contentTextView setText:connectionModel.position forLabel:1];
      [_contentTextView setText:connectionModel.company forLabel:2];
      [_contentTextView refresh];
```
效果图：
![](https://github.com/hanshuaiLoopeer/LPCenterTextView/raw/master/Screenshorts/image2.png)

左边带有icon的文本
```obj-c
    _infoView = [[LPCenterTextView alloc] init];
    _infoView.numberOfLine = 0;
    _infoView.contentFont = [UIFont systemFontOfSize:15];
    _infoView.contentColor = [UIColor grayColor];
    _infoView.leftOffset = 35;
    _infoView.rightOffset = -12;
    _infoView.imageLeftOffset = 12;
    _infoView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_infoView];
```
```obj-c
    [_infoView setText:@"name" andImage:[UIImage imageNamed:@"3"] forLabel:0];
    [_infoView setText:nil andImage:[UIImage imageNamed:@"4"] forLabel:1];
    [_infoView setText:@"ios工程师ios工程师ios工程师ios工程师ios工程师ios工程师" andImage:[UIImage imageNamed:@"1"] forLabel:2];
    [_infoView setText:@"XXX@XXX.com" andImage:[UIImage imageNamed:@"2"] forLabel:3];
    [_infoView refresh];
```
效果图：
![](https://github.com/hanshuaiLoopeer/LPCenterTextView/raw/master/Screenshorts/image3.png)

高度自定义单个Label，可以利用LPCenterTextFeature
```obj-c
    LPCenterTextFeature *firstLabelFeature = [[LPCenterTextFeature alloc] init];
    firstLabelFeature.contentFont = [UIFont systemFontOfSize:15];
    firstLabelFeature.contentColor = [UIColor blackColor];
    firstLabelFeature.numberOfLine = 0;
    
    LPCenterTextFeature *secondLabelFeature = [[LPCenterTextFeature alloc] init];
    secondLabelFeature.contentFont = [UIFont systemFontOfSize:12];
    secondLabelFeature.contentColor = [UIColor whiteColor];
    secondLabelFeature.backgroundColor = [UIColor brownColor];
    secondLabelFeature.wrapContent = YES;
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.layer.cornerRadius = 3;
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.font = [UIFont systemFontOfSize:12];
    _tagLabel.textColor = [UIColor whiteColor];
    _tagLabel.backgroundColor = [UIColor brownColor];
    
    _mainView = [[LPCenterTextView alloc] init];
    _mainView.contentFont = [UIFont systemFontOfSize:12];
    _mainView.contentColor = [UIColor grayColor];
    _mainView.leftOffset = 12;
    _mainView.rightOffset = -12;
    _mainView.textAlignment = NSTextAlignmentLeft;
    [_mainView addTextFeature:firstLabelFeature forLabel:0];
    [_mainView addTextFeature:secondLabelFeature forLabel:1];
    [_mainView setRightView:_tagLabel InIndex:3];
    [self.view addSubview:_mainView];
```
```obj-c
    [_mainView setText:@"第一个label第一个label第一个label第一个label第一个label" forLabel:0];
    [_mainView setText:@" 第二个label " forLabel:1];
    [_mainView setText:nil forLabel:2];
    [_mainView setText:@"第四个label" forLabel:3];
    _tagLabel.text = @" 自定义右View ";
    [_mainView refresh];
```
效果图：
![](https://github.com/hanshuaiLoopeer/LPCenterTextView/raw/master/Screenshorts/image4.png)

其中
```obj-c
[_mainView setRightView:_tagLabel InIndex:3];
```
设置该label右边的自定义view
