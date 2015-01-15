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

@interface CoinOverallViewController ()
@property NSUInteger cellNumEachRow;
@end

@implementation CoinOverallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupLayout];
    [[DataCenter center] requestPrice];
}

-(void)viewWillAppear:(BOOL)animated{
    for ( CoinCell* cell in self.coinCells){
        [[DataCenter center] addDataObserver:cell];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    for ( CoinCell* cell in self.coinCells){
        [[DataCenter center] removeDataObserver:cell];
    }
}

- (void) setupLayout{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        self.cellNumEachRow = CELL_EACH_ROW_POR;
    }else{
        self.cellNumEachRow = CELL_EACH_ROW_LAND;
    }
//    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = NSLocalizedString(@"BBCoin", nil);
    UIImageView* imageView =
    [[UIImageView alloc] initWithImage:[Utils imageWithImage:[UIImage imageNamed:@"bg_main_5"] scaledToSize:self.view.frame.size]];
    ;
//    CGRect allCoinViewFrame = self.view.frame;
//    allCoinViewFrame.origin.y = self.navigationController.navigationBar.frame.size.height;
    
    self.coinCellsContainer = [[UIView alloc] init];
    self.coinCellsContainer.translatesAutoresizingMaskIntoConstraints = NO;
    self.coinCellsContainer.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
    [self.view addSubview:self.coinCellsContainer];

    
    _coinCells = [[NSMutableArray alloc] initWithCapacity:[DataCenter center].coinNum];
    for (int i = 0; i < [DataCenter center].coinNum; ++i) {
        CoinCell * cell = [[CoinCell alloc] init];
        [cell setCoinID:i];
        [self.coinCells addObject:cell];
        [self.coinCellsContainer addSubview:cell];
    }
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
//    UIEdgeInsets margin = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.coinCellsContainer mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).offset(8);
        make.right.equalTo(self.view.mas_right).offset(-8);
        make.top.equalTo(self.view.mas_top).offset(88);
        //        make.bottom.le(self.view.mas_bottom);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
