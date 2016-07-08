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
#import "SwipeInteractiveTransition.h"



#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height


static NSString * cellId = @"UICollectionViewCell";

@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;

@property (nonatomic, strong)SwipeInteractiveTransition * swipeInteractive;


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
    
    self.swipeInteractive = [collectionInfoVC returnSwipeInteractiveTransition];
    
    self.navigationController.delegate = self;
    
    [collectionInfoVC setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:collectionInfoVC animated:YES];
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return  self.swipeInteractive.interacting ? self.swipeInteractive : nil;

}

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
