//
//  MyCollectionViewController.m
//  CollectionViewTest
//
//  Created by 能登 要 on 12/09/28.
//  Copyright (c) 2012年 irimasu. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"

@interface MyCollectionViewController ()
{
    NSArray* _arrayValue;
 
    __weak IBOutlet UISlider *_sliderLayout;
    CGFloat _edgeSize;
}
@end

@implementation MyCollectionViewController

- (void) firedLayoutChange:(id)sender
{
    [self.collectionView reloadData];
}

- (IBAction)firedLayeout:(id)sender
{
    if( [sender isKindOfClass:[UISlider class]]
       ){
        UISlider* slider = sender;
        _edgeSize = 100.0f + (slider.value -.5f) * 50.0f;
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(firedLayoutChange:) withObject:nil afterDelay:0.25];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(_edgeSize,_edgeSize);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _edgeSize = 100.0f;
    _arrayValue = @[ @1,@2,@3,@4,@5,@6,@7,@8,@9
                    ,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20
                    ,@20,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30
                    ,@30,@31,@32,@33,@34,@35,@36,@37,@38,@39,@40
                    ,@40,@41,@42,@43,@44,@45,@46,@47,@48,@49,@50
                    ,@50,@51,@52,@53,@54,@55,@56,@57,@58,@59,@60
                    ,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70
                    ,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79,@80
                    ,@80,@81,@82,@83,@84,@85,@86,@87,@88,@89,@90];
    _sliderLayout.value = .5f;
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(firedRefresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"引っ張って更新" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, nil] ];
    
    [self.collectionView addSubview:refreshControl];
}

- (void)firedRefresh:(id)sender
{
    NSLog(@"Refresh: call");
    
    UIRefreshControl* refreshControl = sender;
    [refreshControl endRefreshing];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arrayValue count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycollectioncell" forIndexPath:indexPath];
    
    cell.labelCaption.text = [[_arrayValue objectAtIndex:indexPath.row] description];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusableView = nil;
    if( [kind compare:UICollectionElementKindSectionHeader] == NSOrderedSame ){
        /*UICollectionReusableView **/ reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"myreusableview" forIndexPath:indexPath];
        
    }else if([kind compare:UICollectionElementKindSectionFooter] == NSOrderedSame ){
         reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"myreusableview2" forIndexPath:indexPath];
    }
    
    
    return reusableView;
}

@end
