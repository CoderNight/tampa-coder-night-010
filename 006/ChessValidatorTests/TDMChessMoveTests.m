//
//  TDMChessMoveTests.m
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TDMChessMove.h"

@interface TDMChessMoveTests : XCTestCase
{
    TDMChessMove* objChessMove;
}

@end

@implementation TDMChessMoveTests

- (void)setUp
{
    [super setUp];
    
    TDMChessMove* objMove1 = [[TDMChessMove alloc] initWithMoves:@"a2 a3"];
    TDMChessMove* objMove2 = [[TDMChessMove alloc] initWithMoves:@"a2 a4"];
    TDMChessMove* objMove3 = [[TDMChessMove alloc] initWithMoves:@"a2 a5"];
    TDMChessMove* objMove4 = [[TDMChessMove alloc] initWithMoves:@"a7 a6"];
    
    
    NSMutableArray* arrMoves = [[NSMutableArray alloc] initWithArray:@[objMove1, objMove2, objMove3, objMove4]];
    
    
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testThatAMoveExists
{
    XCTAssertNotNil(objChessMove, @"should be able to test a chess move");
}


- (void)testThatChessMoveHasAStartingMove
{
    XCTAssertEqualObjects(objChessMove.startMove, @"a2", @"the Chess Move should have a start move");
}

- (void)testThatChessMoveHasAnEndingMove
{
    XCTAssertEqualObjects(objChessMove.endingMove, @"a3", @"the Chess move hsould have an ending move");
}

- (void)testThatChessMoveHasStartingXPos
{
    XCTAssertEqual(objChessMove.startXPos, (int)1, @"the Chess move should have starting xPos");
}

- (void)testThatChessMoveHasStartingYPos
{
    XCTAssertEqual(objChessMove.startYPos, (int)2, @"the Chess move should have starting xPos");
}

@end
