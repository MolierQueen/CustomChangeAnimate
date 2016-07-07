//
//  CollectionViewController.m
//  CustomAnimate
//
//  Created by meitu on 16/7/7.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionInfoConttroller.h"
#import "CustomCollectionCell.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height



/*
 A => 18    B => 20   C => 25
 竞日孤鸣：    B5    		20
 老豆芽：	     A2      	18
 鱼头：       B2         20
 JCMan：	     A6         18
 何b：	     B3         20
 侯建堃：	     B6         20
 高阳：       B2         20
 陈伯佳：      A4        	18
 宁浩：	     A7         18
 */




static NSString * cellId = @"UICollectionViewCell";

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollection;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setTitle:@"仿制系统相册动画"];
    
    [self.mainCollection registerNib:[UINib nibWithNibName:@"CustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:cellId];
    
    self.collectionLayout.itemSize = CGSizeMake((SCREENWIDTH - 80) / 3, (SCREENWIDTH - 80) / 3);
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    
    return cell;
    
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
