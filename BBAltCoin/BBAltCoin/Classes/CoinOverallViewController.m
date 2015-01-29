//
//  ViewController.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "CoinOverallViewController.h"
#import "CoinCell.h"
#import "DataCenter.h"
#import "Macro.h"
#import "Utils.h"
#import "Masonry.h"
#import "AAPullToRefresh.h"
#import "BBImageManager.h"

@interface CoinOverallViewController ()
@property NSUInteger cellNumEachRow;
@end

@implementation CoinOverallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = NSLocalizedString(@"BBAltcoin", nil);
    
    self.pullToRefresh = [self.scrollView addPullToRefreshPosition:AAPullToRefreshPositionTop ActionHandler:^(AAPullToRefresh *v) {
        [[DataCenter center] requestPrice];
    }];
//    [self.scrollView triggerPullToRefresh];
    self.pullToRefresh.borderColor = [UIColor whiteColor];
    self.pullToRefresh.borderWidth = 1.5;
    self.pullToRefresh.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    

    
    
    [[BBImageManager manager] requestLOGO:[[DataCenter center] coinAbbrOfID:0] success:^(NSString *coin, UIImage *image) {
        self.pullToRefresh.imageIcon = [Utils imageWithImage:image scaledToSize:CGSizeMake(30, 30)];
    }];
    
    for (CoinCell* cell in self.coinCells) {
        UITapGestureRecognizer* cellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTaped:)];
        cell.userInteractionEnabled = YES;
        [cell addGestureRecognizer:cellTap];
    }
    
    [[DataCenter center] requestPrice];
}

-(void)viewWillAppear:(BOOL)animated{
    [self judgeFirstLaunch];
    for ( CoinCell* cell in self.coinCells){
        [[DataCenter center] addDataObserver:cell];
    }
    [[DataCenter center] addDataObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    for ( CoinCell* cell in self.coinCells){
        [[DataCenter center] removeDataObserver:cell];
    }
    [[DataCenter center] removeDataObserver:self];
}

- (void) setupLayout{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        self.cellNumEachRow = CELL_EACH_ROW_POR;
    }else{
        self.cellNumEachRow = CELL_EACH_ROW_LAND;
    }
    
    self.title = NSLocalizedString(@"BBCoin", nil);
    UIImageView* imageView =
    [[UIImageView alloc] initWithImage:[Utils imageWithImage:[UIImage imageNamed:@"bg_main_5"] scaledToSize:self.view.frame.size]];
    ;
    self.coinCellsContainer = [[UIView alloc] init];
    [self.view addSubview:imageView];

    _coinCells = [[NSMutableArray alloc] initWithCapacity:[DataCenter center].coinNum];
    for (int i = 0; i < [DataCenter center].coinNum; ++i) {
        CoinCell * cell = [[CoinCell alloc] init];
        [cell setCoinID:i];
        [self.coinCells addObject:cell];
        [self.coinCellsContainer addSubview:cell];
    }
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollViewContainer = [[UIView alloc] init];
    [self.scrollViewContainer addSubview:self.coinCellsContainer];
    
    [self.scrollView addSubview:self.scrollViewContainer];
    
    
    [self.view addSubview:self.scrollView];
    [self updateConstraints];
}

- (void)updateConstraints{
    MASAttachKeys(self.coinCellsContainer);
    int curRow = -1, curCol = 0;

    CoinCell* lastCell = nil;
    CoinCell* lastFloorCell = nil;
    int hMargin = 4, vMargin = 4;
    for (int i = 0; i < self.coinCells.count; ++i) {
        if (i % self.cellNumEachRow == 0) {
            curRow++;
            curCol = 0;
            if (i != 0) {
                lastFloorCell = self.coinCells[i-1];
            }
        }else{
            curCol++;
        }

        ((UIView*)_coinCells[i]).mas_key = [NSString stringWithFormat:@"coinCells[%d,%@]", i, [[DataCenter center] coinAbbrOfID:i ]];
        
         _constraintsArray = [_coinCells[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.height.equalTo(self.coinCells);
            if (curCol == 0) {
                make.left.equalTo(self.coinCellsContainer.mas_left);
                if (i < [DataCenter center].coinNum - 1 ) {
                    make.right.equalTo(((UIView*)self.coinCells[i+1]).mas_left).offset(-hMargin);
                }
            }else{
                make.left.equalTo(((UIView*)self.coinCells[i-1]).mas_right).with.offset(hMargin);
                if( (curCol + 1) % self.cellNumEachRow == 0 ){
                    make.right.equalTo(self.coinCellsContainer.mas_right);
                }else{
                    if (i + 1 < [DataCenter center].coinNum ) {
                        make.right.equalTo(((UIView*)self.coinCells[i+1]).mas_left).offset(-hMargin);
                    }
                }
            }
            if (curRow == 0){
                make.top.equalTo(self.coinCellsContainer.mas_top).offset(vMargin);
            }else{
                make.top.equalTo(lastFloorCell.mas_bottom).offset(vMargin);
            }
            make.width.equalTo(self.coinCells);
        }];
        
        
        lastCell = self.coinCells[i];
        
        
    }
    [lastCell makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.coinCellsContainer.bottom);
    }];
    [self.scrollViewContainer makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(@(SCREEN_HEIGHT+250));
        make.width.equalTo(self.scrollView.width);
    }];
    
//    UIEdgeInsets margin = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.coinCellsContainer mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.scrollViewContainer.left).offset(8);
        make.right.equalTo(self.scrollViewContainer.right).offset(-8);
        make.top.equalTo(self.scrollViewContainer.top).offset(0);
        make.height.equalTo(@250);
    }];
//
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];

}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.cellNumEachRow = CELL_EACH_ROW_POR;
    }else{
        self.cellNumEachRow = CELL_EACH_ROW_LAND;
    }
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    // TODO: Warings!
    // There would be lots warnings if these constraints hadn't been removed before new constraints added
    // I don't know how to resolve it.
    for (CoinCell* cell in self.coinCells)
        for (MASConstraint *constraint in [MASViewConstraint installedConstraintsForView:cell]) {
            [constraint uninstall];
        }
    [self updateConstraints];
   
}

-(IBAction)cellTaped:(UITapGestureRecognizer*)sender{
    CoinCell* cell = (CoinCell*)(sender.view);
    if (self.delegate && [self.delegate respondsToSelector:@selector(onCoinCellTaped:)]) {
        [self.delegate onCoinCellTaped:cell.coinID];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) firstLaunchGuide{
    UIImageView* v = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide"]];
    [self.view addSubview:v];
    [v makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    v.userInteractionEnabled = YES;
    UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeGuide:)];
    [v addGestureRecognizer:tap];
}
-(void) removeGuide:(UIGestureRecognizer*)sender{
    [sender.view removeFromSuperview];
}
-(void) judgeFirstLaunch{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasGuided"]) {
        // app already launched
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasGuided"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self firstLaunchGuide];
    }
}

#pragma mark - DataCenterDelegate
- (void)priceRequestCompletedWithStatus:(int)st{
    [self.pullToRefresh stopIndicatorAnimation];
}
@end
