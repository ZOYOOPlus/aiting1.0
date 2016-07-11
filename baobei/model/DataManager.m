//
//  DataManager.m
//  baobei
//
//  Created by 贺少虎 on 16/4/25.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "DataManager.h"
#import "AdsModel.h"
#import "ActivityModel.h"
#import "MusicData.h"
#import "ListenData.h"
#import "HCommon.h"


static DataManager *_dataManager;


@implementation DataManager
+ (DataManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager = [[DataManager alloc] init];
    });
    
    return _dataManager;
}

- (NSMutableArray *)getAdsArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"听";
        ads.imageName = @"update/ting.png";
        ads.imageHight = @"update/ting1.png";
        ads.color = @"#FCD217";
        [array addObject:ads];
    }
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"画";
        ads.imageName = @"update/hua.png";
        ads.imageHight = @"update/hua2.png";
        ads.color = @"#FD967A";
        [array addObject:ads];
    }
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"拍";
        ads.imageName = @"update/xiu.png";
        ads.imageHight = @"update/xiu1.png";
        ads.color = @"#86B5F7";
        [array addObject:ads];
    }
//    {
//        AdsModel *ads = [[AdsModel alloc] init];
//        ads.title = @"课";
//        ads.imageName = @"home_learn";
//        ads.color = @"#A3D94C";
//        [array addObject:ads];
//    }
    
    return array;
}

- (NSMutableArray *)getLearnAdsArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];

    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"看";
        ads.imageName = @"update/kan0.png";
        ads.imageHight = @"update/kan2.png";
        ads.color = @"#A3D94C";
        [array addObject:ads];
    }
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"听";
        ads.imageName = @"update/ting.png";
        ads.imageHight = @"update/ting1.png";
        ads.color = @"#FCD217";
        [array addObject:ads];
    }
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"练";
        ads.imageName = @"update/lian.png";
        ads.imageHight = @"update/lian2.png";
        ads.color = @"#FF87B2";
        [array addObject:ads];
    }
    return array;

}

- (NSMutableArray *)getShopAdsArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"限时";
        ads.imageName = @"shop1.png";
        ads.color = @"#BE92ED";
        [array addObject:ads];
    }
    
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"精选";
        ads.imageName = @"jin.png";
        ads.color = @"#FB7E6F";
        [array addObject:ads];
    }
    
    {
        AdsModel *ads = [[AdsModel alloc] init];
        ads.title = @"一起玩";
        ads.imageName = @"wan.png";
        ads.color = @"#FF87B2";
        [array addObject:ads];
    }
    return array;
}

- (NSMutableArray *)getListenList{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"music2.png";
        data.title = @"哄睡";
        [array addObject:data];

    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"music.png";
        data.title = @"故事";
        [array addObject:data];

    }
    
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"duxie.png";
        data.title = @"读写";
        [array addObject:data];

    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"guanchali.png";
        data.title = @"观察力";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"zhuanzhuli.png";
        data.title = @"专注力";
        [array addObject:data];
    }
    
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"zhuanzhuli.png";
        data.title = @"专注力";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"yundongnengli.png";
        data.title = @"运动能力";
        [array addObject:data];

    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"xiangxiangli.png";
        data.title = @"想象力";
        [array addObject:data];

    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"记忆力.png";
        data.title = @"记忆力";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"逻辑思维";
        data.title = @"逻辑思维";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"情感发展.png";
        data.title = @"情感发展";
        [array addObject:data];
    }
    {
        ListenData *data = [[ListenData alloc] init];
        data.imageName = @"情感发展.png";
        data.title = @"情感发展";
        [array addObject:data];
    }
    return array;
}

- (NSMutableArray *)getActivityData{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"在这个需要个性的年代，乖孩子也许就不再是个褒义词了。";
        activity.media_name = @"育儿智囊 0评论 2016-07-2 08:49";
        
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        
        [imageList addObject:@"http://p3.pstatp.com/list/9aa00039e6a65b214db"];
        [imageList addObject:@"http://p3.pstatp.com/list/9e100021a7530929bc8"];
        [imageList addObject:@"http://p1.pstatp.com/list/9aa00039f55e8efff6e"];
        activity.image_list = imageList;
        activity.display_url = @"http://toutiao.com/group/6300285178170736897/";
        [array addObject:activity];
    }
    
    {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"大人看《冰与火之歌》，小朋友看《冰龙》";
        activity.media_name = @"青稞营 0评论 2016-07-2 11:32";
        
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        
        [imageList addObject:@"http://p1.pstatp.com/list/412001b34eb63c0857c"];
        [imageList addObject:@"http://p1.pstatp.com/list/412001b34f290049cea"];
        [imageList addObject:@"http://p3.pstatp.com/list/411001b2969c91229a4"];
        activity.image_list = imageList;
        activity.display_url = @"http://toutiao.com/group/6289209508443619586/";
    
        [array addObject:activity];
    }
    
    {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"“爱家创酷”儿童未来学习嘉年华开幕";
        activity.media_name = @"手机人民网 0评论 2016-07-2 10:59";
        
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        
        [imageList addObject:@"http://p2.pstatp.com/list/6c10005de17547cfd4a"];
        [imageList addObject:@"http://p3.pstatp.com/list/6eb0005dbe125455130"];
        [imageList addObject:@"http://p3.pstatp.com/list/6c50005e6ab8a0b9c72"];
        activity.image_list = imageList;
        activity.display_url = @"http://m2.people.cn/r/MV8xXzI4Mzg5ODM4XzE5MDk3MF8xNDY0NTc0MDI5?zzd_from=uc-iflow&sm_article_id=1075524273931209325&dl_type=3&uc_biz_str=S%3Acustom%7CC%3Aiflow_ncmt%7CK%3Atrue&rd_type=reco&recoid=8574310819051661368";

        [array addObject:activity];
    }
    
    {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"半杯咖啡读好书";
        activity.media_name = @"半杯咖啡读好书 0评论 2016-05-30 09:21";
        
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        [imageList addObject:@"http://p3.pstatp.com/list/411001c09e90873e12c"];
        [imageList addObject:@"http://p2.pstatp.com/list/411001c09ef237b3476"];
        [imageList addObject:@"http://p3.pstatp.com/list/412001c14c6ad5909f4"];
        activity.image_list = imageList;
        activity.display_url = @"http://toutiao.com/group/6290302795711971585/";
        
        [array addObject:activity];
    }
    {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"半杯咖啡读好书";
        activity.media_name = @"半杯咖啡读好书 0评论 2016-05-30 09:21";
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        [imageList addObject:@"http://p3.pstatp.com/list/411001c09e90873e12c"];
        [imageList addObject:@"http://p2.pstatp.com/list/411001c09ef237b3476"];
        [imageList addObject:@"http://p3.pstatp.com/list/412001c14c6ad5909f4"];
        activity.image_list = imageList;
        activity.display_url = @"http://toutiao.com/group/6290302795711971585/";
        [array addObject:activity];
    }
       {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"读绘本学英文？见鬼去吧！";
        activity.media_name = @"娘娘说 0评论 2016-07-2 08:49";
        
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        
        [imageList addObject:@"http://p3.pstatp.com/list/72300036a19064aa1a6"];
        [imageList addObject:@"http://p3.pstatp.com/list/72300036a77c1888e11"];
        [imageList addObject:@"http://p3.pstatp.com/list/6d00008a20ed63da059"];
        activity.image_list = imageList;
        activity.display_url = @"http://toutiao.com/group/6290106590851449089/";
        
        [array addObject:activity];
    }
 
    {
        ActivityModel *activity = [[ActivityModel alloc] init];
        activity.title = @"在这个需要个性的年代，乖孩子也许就不再是个褒义词了。";
        activity.media_name = @"育儿智囊 0评论 2016-07-2 08:49";
        
        NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:1];
        
        [imageList addObject:@"http://p3.pstatp.com/list/9aa00039e6a65b214db"];
        [imageList addObject:@"http://p3.pstatp.com/list/9e100021a7530929bc8"];
        [imageList addObject:@"http://p1.pstatp.com/list/9aa00039f55e8efff6e"];
        activity.image_list = imageList;
        activity.display_url = @"http://toutiao.com/group/6300285178170736897/";
        
        [array addObject:activity];
    }
    return array;
}

- (NSArray *)getActivityTitleData{
   //  return @[@"头条推荐", @"童书绘本",@"90后妈妈",@"明星育儿"];
        return @[@"头条推荐"];

}

- (NSMutableArray *)getProfileConfigArray{
    // 头像
    // 名字
    NSMutableArray *profiles = [[NSMutableArray alloc] initWithCapacity:1];
    NSString *titleKey = @"title";
    NSString *imageKey = @"image";
    // 打卡积分
    NSMutableArray *section = [[NSMutableArray alloc] initWithCapacity:1];
    if([AVUser currentUser] == NULL){
        [section addObject:@{titleKey:@"点击登录",imageKey:@"yazi.png"}];
        //[section addObject:@{titleKey:@"点击注册",imageKey:@"profile_regist"}];
    }else{
        NSString* nickname = [[AVUser currentUser] username];
        [section addObject:@{titleKey:nickname,imageKey:@"yazi.png"}];
    }
    
    [profiles addObject:section];
    

    section = [[NSMutableArray alloc] initWithCapacity:1];
    [section addObject:@{titleKey:@"积分",imageKey:@"profile_logistics"}];
    [section addObject:@{titleKey:@"任务",imageKey:@"profile_order"}];
    [section addObject:@{titleKey:@"兑换",imageKey:@"profile_discount"}];
    //[section addObject:@{titleKey:@"收藏",imageKey:@"profile_collect"}];
    [profiles addObject:section];
    
    section = [[NSMutableArray alloc] initWithCapacity:1];
    
    [section addObject:@{titleKey:@"收藏",imageKey:@"profile_collect"}];
    [section addObject:@{titleKey:@"设置",imageKey:@"profile_set"}];
    if([AVUser currentUser] != NULL){
        [section addObject:@{titleKey:@"退出登录",imageKey:@"profile_loginout"}];
    }
    [profiles addObject:section];
    
    return profiles;
}





- (void)updateStatus{
//    if (!_streamer) {
//        return;
//    }
    if (_listenCell) {
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
        anim.fromValue = @(M_PI/180 * 0);
        anim.toValue = @(M_PI/180 * 3600);
//        anim.duration = [_streamer duration];
        [_listenCell.imageView.layer pop_addAnimation:anim forKey:@"Rotation"];
    
    }
    
}

//        data.musicURL = @"http://res.wx.qq.com/voice/getvoice?mediaid=MzA5Mjk1MTk5Nl80MDMyMjgxODY=";
//        data.name = @"长大做个好爷爷";

- (NSMutableArray *)getMusicData{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
    {
        MusicData  *data = [[MusicData alloc] init];
        data.musicURL = @"http://audio.xmcdn.com/group13/M05/6E/84/wKgDXVc7N33ST3ZuAFIFIhmC6ac098.m4a";
        data.name = @"智慧小姐";
        data.musicPic = @"test.jpg";
        data.artistName = @"凯叔";
        [array addObject:data];
    }
    
    {
        MusicData  *data = [[MusicData alloc] init];
        data.musicURL = @"http://audio.xmcdn.com/group16/M06/6E/3E/wKgDalc7NPfDsjEyAF5JwQWHKB0355.m4a";
        data.name = @"聪明先生";
        data.artistName = @"凯叔";
        data.musicPic = @"test.jpg";
        [array addObject:data];
    }
    return array;
}

- (NSMutableArray *)getVideoList{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
    
    return array;
}
@end
