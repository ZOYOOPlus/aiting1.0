//
//  ShareVC.m
//  jyt
//
//  Created by 贺少虎 on 16/5/23.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ShareVC.h"
#import "HShareCell.h"

static NSString *cellID = @"cellID";

@interface ShareVC ()<UICollectionViewDelegate, UICollectionViewDataSource>{
    BOOL delay;
}

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UICollectionView *collectionUp;

@property (nonatomic, strong) UICollectionView *collectionDown;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIView *line;

@end

@implementation ShareVC

- (UICollectionView *)factoryCollection{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(self.view.bounds.size.width/5 - 10 - 2, 90);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor clearColor];
    [collection registerClass:[HShareCell class] forCellWithReuseIdentifier:cellID];
    collection.showsHorizontalScrollIndicator = NO;
    collection.delegate = self;
    collection.dataSource = self;
    return collection;
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    
    delay = NO;
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.collectionUp];
    [self.view addSubview:self.line];
    [self.view addSubview:self.collectionDown];
    [self setLayout];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self displayAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UICollectionView *)collectionUp{
    if (!_collectionUp) {
        _collectionUp = [self factoryCollection];

    }
    return _collectionUp;
}

- (UICollectionView *)collectionDown{
    if (!_collectionDown) {
        _collectionDown = [self factoryCollection];
        _collectionDown.delegate = self;
        _collectionDown.dataSource = self;
    }
    return _collectionDown;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
//        _cancelButton.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.34 blue:0.36 alpha:1];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];

    }
    return _cancelButton;
}

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.layer.opacity = 0;
    }
    return _maskView;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithRed:0.85 green:0.86 blue:0.9 alpha:1];
    }
    return _bgView;
}


- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 1)];
        _line.backgroundColor = RGB(232, 232, 232);
    }
    return _line;
}

- (void)setLayout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height).multipliedBy(kViewHeightScale).offset(kCancelButtonHeight);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(kCancelButtonHeight);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self.bgView.mas_centerY).offset(-kCancelButtonHeight/2);
    }];
    
    [self.collectionDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.bgView.mas_width);
        make.height.equalTo(self.bgView.mas_height).multipliedBy(0.4).offset(-kCancelButtonHeight/2);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.line.mas_bottom).offset(5);
    }];
    
    [self.collectionUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.bgView.mas_height).multipliedBy(0.4).offset(-kCancelButtonHeight/2);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.line.mas_top).offset(-5);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if (!CGRectContainsPoint(self.bgView.frame, touchPoint)) {
        [self removeAction];
    }
}

#pragma mark collection

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionUp) {
        DLog(@"--上--%zi",indexPath.row);
    }else if( collectionView == self.collectionDown) {
        DLog(@"--下--%zi",indexPath.row);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

#pragma mark animate

- (void)displayAction{
    delay = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-self.bgView.height);
            self.maskView.layer.opacity = 0.3;
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        delay = NO;
    }];
}

- (void)removeAction{
    if (delay) {
        return;
    }
    delay = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom);
            self.maskView.layer.opacity = 0;
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        delay = NO;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark action
- (void)clickCancel{
    [self removeAction];
}

@end
