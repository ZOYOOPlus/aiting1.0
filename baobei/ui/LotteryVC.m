//
//  LotteryVC.m
//  baobei
//
//  Created by 张源海 on 16/8/4.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "LotteryVC.h"
#import "LKLotteryView.h"
#import "DAAutoTableView.h"
#import "TableViewController.h"

@interface LotteryVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIImageView *titleImageView;
@property  (nonatomic,strong)UIImageView *luckImageView;
@property (nonatomic,retain)LKLotteryView *luckView;
@property  (nonatomic,strong)UIButton *jiangbutton;
@property  (nonatomic,strong)UIImageView *jiangImageView;
@property  (nonatomic,strong)UIImageView *zhizhenView;
@property  (nonatomic,strong)UILabel *tipsilabel;
@property  (nonatomic,strong)UILabel *times;

@property  (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) CADisplayLink *link;
@end

@implementation LotteryVC




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    _imageView = [[UIImageView alloc]init];
//    _imageView.frame = CGRectMake(0, -64, self.view.size.width , self.view.size.height);
//    _imageView.image = [UIImage imageNamed:@"抽奖8.jpg"];
//    [self.view addSubview:_imageView];

    [self setupUI];
    
    [self AddtableView];
    
   // [(DAAutoTableView *)self.tableView setPointsPerSecond:20.0f];
   // [(DAAutoTableView *)self.tableView startScrolling];
    
   NSLog(@"frame的大小%@",NSStringFromCGRect(self.tableView.frame));
    [self roatetableView];
}

- (void)startScrolling
{
   // [self stopScrolling];
    
    CGFloat animationDuration = (0.5f / self.pointsPerSecond);
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:animationDuration
                                                    target:self
                                                  selector:@selector(updateScroll)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)stopScrolling
{
    [_scrollTimer invalidate];
    _scrollTimer = nil;
}

- (void)updateScroll
{
    NSLog(@"zanting暂停");
//    CGFloat animationDuration = _scrollTimer.timeInterval;
//    CGFloat pointChange = self.pointsPerSecond * animationDuration;
//    CGPoint newOffset = self.contentOffset;
//    newOffset.y = newOffset.y + pointChange;
//    
//    if (newOffset.y > (self.contentSize.height - self.bounds.size.height))
//    {
//        [self stopScrolling];
//    }
//    else
//    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.contentOffset = newOffset;
//        [UIView commitAnimations];
//    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [(DAAutoTableView *)self.tableView startScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [(DAAutoTableView *)self.tableView startScrolling];
}

// 设置自动旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setupUI{
    _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-260)/2, 40, 260, 60)];
    _titleImageView.image = [UIImage imageNamed:@"抽奖8_4.png"];
    [self.view addSubview:_titleImageView];
    
    
    _luckView = [[LKLotteryView alloc]initWithFrame:CGRectMake((fDeviceWidth-220)/2, 120, 220,220 )];
    [self.luckImageView addSubview:_luckView];

    _luckImageView = [[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-220)/2, 120, 220,220 )];
    _luckImageView.image = [UIImage imageNamed:@"抽奖8_3.png"];
    [self.view addSubview:_luckImageView];
    
    _luckImageView.userInteractionEnabled=YES;
    
    
    
    _zhizhenView = [[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth/2-7.5, 180+11+3+1, 15,15 )];
    _zhizhenView.image = [UIImage imageNamed:@"抽奖8__1.png"];
    [self.view addSubview:_zhizhenView];
    
    _jiangbutton = [[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth/2-25, 180+25, 50,50 )];
    [_jiangbutton setImage:[UIImage imageNamed:@"抽奖8__2.png"] forState:UIControlStateNormal];
    [_jiangbutton addTarget:self action:@selector(startRotate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_jiangbutton];
    
//    _jiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth/2-25, 180+25, 50,50 )];
//    _jiangImageView.image = [UIImage imageNamed:@"抽奖8__2.png"];
//    [self.view addSubview:_jiangImageView];
    
    _tipsilabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 340, 200, 40)];
    _tipsilabel.text = @"您还有   次抽奖机会";
    _tipsilabel.textColor = [UIColor  brownColor];
    [self.view addSubview:_tipsilabel];
    
    _times = [[UILabel alloc]initWithFrame:CGRectMake(172, 335, 50, 50)];
    _times.text = @"3";
    _times.textColor = [UIColor  orangeColor];
    [self.view addSubview:_times];
    
    
}


-(void)AddtableView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(105, 380, 170, 120)];
    //_tableView.style = UITableViewStylePlain;
    [self.view addSubview:_tableView];
  


}

// 开始旋转轮盘
- (void)startRotate {
    
    // 使用计时器来执行旋转
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(roate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
    if ([_times.text isEqualToString:@"3"]) {
         _times.text =@"2";
    }else if ([_times.text isEqualToString:@"2"]) {
        _times.text =@"1";
    }else if ([_times.text isEqualToString:@"1"]) {
        _times.text =@"0";
    }else if ([_times.text isEqualToString:@"0"]) {
        _jiangbutton.userInteractionEnabled =NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的抽奖机会已经用完" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"确定"];
        [alert show];
    
    }
   
    
}
// 旋转方法
- (void)roate {
    self.luckImageView.transform = CGAffineTransformRotate(self.luckImageView.transform, M_PI_4 * 0.11);
   
    
}

// 旋转方法
- (void)roatetableView {
    self.tableView.transform = CGAffineTransformRotate(self.tableView.transform, M_PI_4 * 0.11);
    //[self.luckView start];
 //    [NSThread sleepForTimeInterval:1.0];
    
//    // 设置6秒后 停止  不好用
//    [UIView animateWithDuration:6.0
//     
//                     animations:^(void) {
//                         [NSThread sleepForTimeInterval:1.0];
//                         [self stoptableView];
//                     }
//     
//     ];
    
}
- (void)stoptableView {
    
   
    self.tableView.transform = CGAffineTransformRotate(self.tableView.transform,
                           M_PI_2*0);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"中奖号码是Row %li", (long)indexPath.row];
    
    return cell;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
@end
