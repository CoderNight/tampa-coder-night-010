//
//  TDMViewController.m
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import "TDMViewController.h"
#import "TDMChessBoard.h"
#import "TDMChessMove.h"

@interface TDMViewController ()

@end

@implementation TDMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initalize];
}

- (void)initalize
{
    [self setDefaults];
    [self addObservers];
    [self createBoard];
}

- (void) setDefaults
{
    
}

- (void) addObservers
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createBoard
{
//    NSString* path      = [[NSBundle mainBundle] pathForResource:@"complex_moves" ofType:@"txt"];
//    NSString* content   = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray*  moves     = [[self complexMoves] componentsSeparatedByString:@"\n"];
    
    NSLog(@"%@", moves);
    
    NSMutableArray* arrMoves = [[NSMutableArray alloc] init];
    
    [moves enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        TDMChessMove* objMove = [[TDMChessMove alloc] initWithMoves:[moves objectAtIndex:idx]];
        [arrMoves addObject:objMove];
     }];
    
    
    NSLog(@"%@", arrMoves);
    
    //TDMChessMove* objMove1 = [[TDMChessMove alloc] initWithMoves:@"b2 b3"];
//    NSMutableArray* arrMoves = [[NSMutableArray alloc] initWithArray:@[objMove1, objMove2, objMove3, objMove4, objMove5, objMove6, objMove7, objMove8]];
//    //, objMove5, objMove6, objMove7, objMove8, objMove9, objMove10, objMove11, objMove12
//    //NSString* path      = [[NSBundle mainBundle] pathForResource:@"complex_moves" ofType:@"txt"];
    NSString* content   = @"bK -- -- -- -- bB -- --\n-- -- -- -- -- bP -- --\n-- bP wR -- wB -- bN --\nwN -- bP bR -- -- -- wP\n-- -- -- -- wK wQ -- wP\nwR -- bB wN wP -- -- --\n-- wP bQ -- -- wP -- --\n-- -- -- -- -- wB -- --";
//    //NSLog(@"%@", content);
    TDMChessBoard* objBoard = [[TDMChessBoard alloc] initWithBoard:content andMoves:arrMoves];
}

- (NSString *) complexMoves
{
    return @"b2 b3\nf2 b7\nb4 a8\na8 g5\nb2 b4\nh7 f6\ne3 b1\nb7 e4\nb2 b5\ng7 g2\nf7 f8\ng7 e8\nf5 g5\nf7 f6\nc3 a2\ne1 c1\nf7 f5\ng8 c6\nb2 d5\nf7 f4\nf6 f3\nc5 f4\nb6 a5\nc3 d7\nb2 f6\ne4 d8\nd2 g6\nb2 c3\na3 g5\nh6 e8\nd3 b5\nd6 f3\nc5 c4\nf6 a3\nb7 c1\nf1 f1\nb6 b4\na7 e5\nb6 c5\nc2 e7\nd4 f5\na7 g8\na7 d1\nc5 b4\nc4 e3\nh4 h3\nb5 b2\nb2 g4\nh3 h4\nh8 d3\nh8 h7\nh2 h3\ne8 c4\na3 a1\nd3 b5\na3 a1\nd5 d3\nd5 f5\nb4 f6\nd5 g2\nc8 d4\nd5 b5\nc6 d5\nf3 b5\na1 g6\ng6 e5\nd3 e6\ng6 a7\ng6 h4\nc6 d8\na3 h8\ng8 f8\nc7 f2\nd3 c4\na5 a4\na5 b5\nf1 a8\nc2 g1\ne5 a4\nh5 f1\ne6 g4\ng5 h2\nc3 b2\nh2 c7\ne6 f3\nc3 c4\nf1 c4\nb3 a6\nc4 b3\nc1 h6\na5 c5\nf4 f7\nc2 c6\nf6 g2\nd2 a1\ne4 a3\nc2 d3\na8 c6\nd6 d1\nc2 e4\nd6 g2\na6 a7\nc2 c4\na8 a7\nc4 d3\nc3 h5\nb4 c7\ne6 d5\nb6 d6\ne5 f8\nf1 f6\na8 a6\na8 c6\ne4 e5\nh2 a5\nc8 e1\ne3 h2\nf3 h3";
}



- (NSArray *)gridPoints
{
    return @[@"a8", @"b8", @"c8", @"d8", @"e8", @"f8", @"g8", @"h8",
             @"a7", @"b7", @"c7", @"d7", @"e7", @"f7", @"g7", @"h7",
             @"a6", @"b6", @"c6", @"d6", @"e6", @"f6", @"g6", @"h6",
             @"a5", @"b5", @"c5", @"d5", @"e5", @"f5", @"g5", @"h5",
             @"a4", @"b4", @"c4", @"d4", @"e4", @"f4", @"g4", @"h4",
             @"a3", @"b3", @"c3", @"d3", @"e3", @"f3", @"g3", @"h3",
             @"a2", @"b2", @"c2", @"d2", @"e2", @"f2", @"g2", @"h2",
             @"a1", @"b1", @"c1", @"d1", @"e1", @"f1", @"g1", @"h1"];
}





@end
