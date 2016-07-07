//
//  CollectionInfoConttroller.m
//  CustomAnimate
//
//  Created by meitu on 16/7/7.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "CollectionInfoConttroller.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface CollectionInfoConttroller ()

@end

@implementation CollectionInfoConttroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationItem setTitle:@"简介"];

    _imageViewC = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [_imageViewC setCenter:CGPointMake(SCREENWIDTH / 2, 190)];
    [_imageViewC setImage:[UIImage imageNamed:@"test"]];
    [self.view addSubview:_imageViewC];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, _imageViewC.frame.size.height + _imageViewC.frame.origin.y + 10, SCREENWIDTH - 60, 0)];
    [label setNumberOfLines:0];
    [label setText:@"    日月魔教纵横四海，势力日盛，欲一统江湖。五岳剑派组成正义联盟，与魔教抗衡。任我行闭关专注神功闭关修炼，东方不败为了日月神教教主之位谋划了这场让五岳剑派进攻日月神教，但是因为任我行闭关修炼，不想和五岳剑派正面交锋，东方不败不甘心，就准备利用任我行的妻子和女儿。当东方不败到任我行闭关的地方报告五岳剑派的情况，任我行决定不正面交锋，但是东方不败不甘心，就派人把任盈盈抓走；　　然后任我行的妻子以为是五岳剑派抓了盈盈，独自一人去找五岳剑派讨要女儿，此时五岳剑派正在黑木崖下，正在想如何登上黑木崖，任夫人以为五岳剑派抓走就和嵩山派掌门左冷禅被擒获。傍晚，华山派岳不群的夫人看不惯左冷禅的做法，就把任夫人放了，并告诉他们并没有上黑木崖，所以没有抓走她的女儿，当任夫人走后，就被自己师兄发现了，但是并没有阻拦，突然大家都醒了一起都去寻找任夫人。任夫人回到黑木崖告诉东方不败说并没看见盈盈，但是东方不败为了自己的计划，直接就杀死了任夫人"];
    [label sizeToFit];
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
