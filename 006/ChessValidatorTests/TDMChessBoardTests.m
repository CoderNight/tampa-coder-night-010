//
//  TDMChessBoardTests.m
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TDMChessBoard.h"
#import "TDMChessMove.h"

@interface TDMChessBoardTests : XCTestCase
{
    TDMChessBoard* chessBoard;
    
}

@end

@implementation TDMChessBoardTests

- (void)setUp
{
    [super setUp];
    
    TDMChessMove* objMove1 = [[TDMChessMove alloc] initWithMoves:@"a2 a3"];
    TDMChessMove* objMove2 = [[TDMChessMove alloc] initWithMoves:@"a2 a4"];
    TDMChessMove* objMove3 = [[TDMChessMove alloc] initWithMoves:@"a2 a5"];
    TDMChessMove* objMove4 = [[TDMChessMove alloc] initWithMoves:@"a7 a6"];
    
    
    NSMutableArray* arrMoves = [[NSMutableArray alloc] initWithArray:@[objMove1, objMove2, objMove3, objMove4]];
    
    chessBoard = [[TDMChessBoard alloc] initWithBoard:@"simple_board.txt" andMoves:arrMoves];
    
}

- (void)testThatABoardExists
{
    XCTAssertNotNil(chessBoard, @"should be able to create a chessboard");
}

- (void)testBoardHasTextFile
{
    XCTAssertEqualObjects(chessBoard.board, @"simple_board.txt", @"should be able to load a chess board text file");
}

- (void)testBoardHasContent
{
    XCTAssertEqualObjects(chessBoard.boardContent, @"bR bN bB bQ bK bB bN bR\nbP bP bP bP bP bP bP bP\n-- -- -- -- -- -- -- --\n-- -- -- -- -- -- -- --\n-- -- -- -- -- -- -- --\n-- -- -- -- -- -- -- --\nwP wP wP wP wP wP wP wP\nwR wN wB wQ wK wB wN wR", @"should be able to load content for board");
}

- (void)testThatBoardHasBoardSet
{
    XCTAssertNotNil([chessBoard.dictPositions valueForKey:@"a2"], @"should have board position set");
}

- (void)testThatBoardIsSet
{
    XCTAssertEqualObjects([chessBoard.dictPositions valueForKey:@"a2"], @"wP", @"board should return wP");
}

- (void)testThatBoardHasMoves
{
    XCTAssertNotNil([chessBoard.arrMoves objectAtIndex:0], @"chess board has at least one move");
}


- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

@end
