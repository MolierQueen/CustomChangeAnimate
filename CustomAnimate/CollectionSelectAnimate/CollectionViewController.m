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

#import "CustomAnimate.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height



/*
 A => 18    B => 20   C => 25
 竞日孤鸣：    B5    	   20
 老豆芽：	     A2      	   18
 鱼头：          B2         20
 俊成：	         A6         18
 何子杰：	     B3         20  => 已支付
 侯剑堃：	     B6         20
 高阳：          B2         20
 陈柏佳：      A4         18
 嘉姐：         B4          20
 EMMA:        C1          25
 宁浩：	        A7         18

 杨振楠        A3 * 2    36 => 已支付
 钱小静        A2          18 => 已支付
 
 合计  B5=>1   A2=>2  B2=>2  A6=>1  B3=>1  B6=> 1  A4=>1  B4=>1  C1=>1  A7=>1  A3=>2  271元
 */
 





static NSString * cellId = @"UICollectionViewCell";

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setTitle:@"系统动画"];
    
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _currentIndexPath = indexPath;
    
    CollectionInfoConttroller * collectionInfoVC = [[CollectionInfoConttroller alloc] init];
    
    self.navigationController.delegate = self;
    
    [collectionInfoVC setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:collectionInfoVC animated:YES];
    
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//    
//    
//    
//}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    return [CustomAnimate createCustomAnimateWithType:operation == UINavigationControllerOperationPush ? CustomAnimateTypePush : CustomAnimateTypePop];
    
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
