//
//  ActivityCell.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "ActivityCell.h"
#import "HImageListCell.h"

static NSString *cellID = @"HImageListCell";

@interface ActivityCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *attribute;
@property (nonatomic,strong) UIImageView *likeImageView;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ActivityCell

+ (UICollectionViewFlowLayout *)getFlowLayout{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kActivityImageWidth, kActivityImageHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FEFFFF"];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.attribute];
        //[self.contentView addSubview:self.likeImageView];
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.font = [UIFont fontWithName:APP_FONT size:15];
        _title.textColor = [UIColor colorWithHexString:@"#171717"];
    }
    return _title;
}

- (UILabel *)attribute{
    if (!_attribute) {
        _attribute = [[UILabel alloc] initWithFrame:CGRectZero];
        _attribute.font = [UIFont fontWithName:APP_FONT size:10];
        _attribute.textColor = [UIColor colorWithHexString:@"#171717"];
    }
    return _attribute;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_like"] highlightedImage:[UIImage imageNamed:@"home_like_high"]];
    }
    return _likeImageView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.frame), kActivityImageHeight) collectionViewLayout:[[self class] getFlowLayout]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HImageListCell class] forCellWithReuseIdentifier:cellID];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}


- (void)setActivityModel:(ActivityModel *)activityModel{
    if (_activityModel == activityModel) {
        return;
    }
    _activityModel = activityModel;
    self.title.text = _activityModel.title;
//    NSString *attributeText = @"";
//    attributeText = [attributeText stringByAppendingString:_activityModel.author];
//    attributeText = [attributeText stringByAppendingString:@"  "];
//    attributeText = [attributeText stringByAppendingString:_activityModel.ti];
    //加载JSON
  //  self.attribute.text = _activityModel.media_name;
    
      self.attribute.text = _activityModel.author;
    [self.collectionView reloadData];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.title sizeToFit];
    [self.attribute sizeToFit];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];

    [self.attribute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
//    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        make.size.mas_equalTo(CGSizeMake(52/2, 45/2));
//    }];
}


#pragma mark uicollection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.activityModel.imageList.count;
    return self.activityModel.imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HImageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
  
    // 处理JSon 数据时  显示的Cell
//    if (self.activityModel.image_list.count != 0) {
//        [cell.imageView yy_setImageWithURL:[NSURL URLWithString:self.activityModel.image_list[indexPath.row][@"url"]] placeholder:[UIImage imageNamed:@"head.jpg"]];
//    }
    
      //  不处理Json时显示的数据
     [cell.imageView setYy_imageURL:[NSURL URLWithString:self.activityModel.imageList[indexPath.row]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self setSelected:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectImageViewListAtIndex:data:)]) {
        
        [self.delegate selectImageViewListAtIndex:self.indexPath data:self.activityModel];
    }

}

@end
