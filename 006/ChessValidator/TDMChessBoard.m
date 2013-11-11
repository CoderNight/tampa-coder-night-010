//
//  TDMChessBoard.m
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import "TDMChessBoard.h"
#import "TDMChessMove.h"

#define kPawn @"Pawn"
#define kRook @"Rook"
#define kKnight @"Knight"
#define KBishop @"Bishop"
#define kQueen @"Queen"
#define kKing @"King"
#define kNoPiece @"NA"





@implementation TDMChessBoard

- (id)initWithBoard:(NSString *)board andMoves:(NSArray *)moves
{
    if ((self = [super init]))
    {
        self.dictBoard      = [[NSMutableDictionary alloc] init];
        self.arrMoves       = [[NSMutableArray alloc] initWithArray:moves];
        self.arrResults     = [[NSMutableArray alloc] init];
        self.boardContent   = board;
        
        [self createBoard];
        //[self createMoves];
        
        
        [self.arrMoves enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop){
            TDMChessMove* objChessMove = [self.arrMoves objectAtIndex:idx];
            NSString* piece = [self.dictBoard valueForKey:objChessMove.startMove];
            NSString* endPiece = [self.dictBoard valueForKey:objChessMove.endingMove];
            
            if ([[self getChessPieceColor:endPiece] isEqualToString:@"-"] ||
                ![[self getChessPieceColor:endPiece] isEqualToString:[self getChessPieceColor:piece]])
            {
                if ([[self getChessPieceType:piece] isEqualToString:kPawn]) [self.arrResults addObject:[self evaluatePawnMove:objChessMove]];
                if ([[self getChessPieceType:piece] isEqualToString:kKnight]) [self.arrResults addObject:[self evaluateKnight:objChessMove]];
                if ([[self getChessPieceType:piece] isEqualToString:kKing]) [self.arrResults addObject:[self evaluateKing:objChessMove]];
                if ([[self getChessPieceType:piece] isEqualToString:kRook]) [self.arrResults addObject:[self evaluateRook:objChessMove]];
                if ([[self getChessPieceType:piece] isEqualToString:KBishop]) [self.arrResults addObject:[self evaluateBishop:objChessMove]];
                if ([[self getChessPieceType:piece] isEqualToString:kNoPiece]) [self.arrResults addObject:@"ILLEGAL"];
                if ([[self getChessPieceType:piece] isEqualToString:kQueen]) [self.arrResults addObject:@"NO CODE FOR QUEEN"];
            }
            else [self.arrResults addObject:@"ILLEGAL"];
          
            
            NSLog(@"start piece color: %@", [self getChessPieceColor:piece]);
            NSLog(@"end piece color: %@", [self getChessPieceColor:endPiece]);
            
        }];
    }
    
    NSLog(@"%@", self.arrResults);
    
    
    return self;
}

- (void) createBoard
{
    NSArray* board =[self.boardContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n"]];
    
    [board enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop)
     {
         NSString* position = [[self gridPoints] objectAtIndex:idx];
         [self.dictBoard setObject:[board objectAtIndex:idx] forKey:position];
     }];
    
    NSLog(@"%@", self.dictBoard);
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

- (NSString *) getChessPieceType:(NSString *)type
{
    //NSLog(@"type = %@", [type substringFromIndex:1]);
    NSString* chessPiece = [type substringFromIndex:1];
    
    if ([chessPiece isEqualToString:@"P"])      return kPawn;
    else if ([chessPiece isEqualToString:@"R"]) return kRook;
    else if ([chessPiece isEqualToString:@"N"]) return kKnight;
    else if ([chessPiece isEqualToString:@"Q"]) return kQueen;
    else if ([chessPiece isEqualToString:@"K"]) return kKing;
    else if ([chessPiece isEqualToString:@"B"]) return KBishop;
    else return @"NA";
}

- (NSString *) getChessPieceColor:(NSString *)type
{
    //NSString* chessPiece = [type substringToIndex:0];
    
    return [type substringToIndex:1];
}


#pragma mark - Evalute Chess Moves

- (NSString *) evaluatePawnMove:(TDMChessMove *)move
{
    TDMChessMove* objChessMove = move;
    int numYPos = objChessMove.endingYPos - objChessMove.startYPos;
    BOOL isXPosEqual = objChessMove.endingXPos == objChessMove.startXPos;
    NSString* piece = [self.dictBoard valueForKey:objChessMove.startMove];
    NSString* color = [self getChessPieceColor:piece];
    NSString* result = @"";
    
    if (numYPos < 0)
    {
        numYPos = -numYPos;
    }
    
    NSLog(isXPosEqual ? @"Yes" : @"No");
    
    NSLog(@"ypos result: %i", numYPos);
    
    if (isXPosEqual && numYPos == 1)
    {
        if ([color isEqualToString:@"w"])
        {
            if (objChessMove.endingYPos < objChessMove.startYPos)
            {
               result = @"ILLEGAL PAWN";
            }
            else result = @"LEGAL PAWN";
        }
        else
        {
            if (objChessMove.endingYPos > objChessMove.startYPos)
            {
                result = @"ILLEGAL PAWN";
            }
            else result = @"LEGAL PAWN";
        }
    }
    else result = @"ILLEGAL PAWN";
    
    return result;
}

- (NSString *) evaluateKnight:(TDMChessMove *)move
{
    int numXPos = move.endingXPos - move.startXPos;
    int numYPos = move.endingYPos - move.startYPos;
    
    if (numYPos < 0)
    {
        numYPos = -numYPos;
    }
    
    if (numXPos < 0)
    {
        numXPos = -numXPos;
    }
    
    NSLog(@"knight x:%i y:%i startmove: %@ endmove: %@", numXPos, numYPos, move.startMove, move.endingMove);
    
    if (numXPos == 1 && numYPos == 2)
    {
        return @"LEGAL";
    }
    else if (numXPos == 2 && numYPos == 1)
    {
        return @"LEGAL";
    }
    else return @"ILLEGAL";
}

- (NSString *) evaluateKing:(TDMChessMove *)move
{
    // x2 - x1 less than or equal 1 and y2 - y1 less than equal 1
    
    int numXPos = move.endingXPos - move.startXPos;
    int numYPos = move.endingYPos - move.startYPos;
    
    if (numYPos < 0)
    {
        numYPos = -numYPos;
    }
    
    if (numXPos < 0)
    {
        numXPos = -numXPos;
    }
    
    if (numXPos <= 1 && numYPos <= 1)
    {
        return @"LEGAL";
    }
    else return @"ILLEGAL";
}

- (NSString *) evaluateBishop:(TDMChessMove *)move
{
    int numXPos = move.endingXPos - move.startXPos;
    int numYPos = move.endingYPos - move.startYPos;
    
    if (numYPos < 0)
    {
        numYPos = -numYPos;
    }
    
    if (numXPos < 0)
    {
        numXPos = -numXPos;
    }
    
    if (numXPos == numYPos)
    {
        return @"LEGAL";
    }
    else return @"ILLEGAL";
}

- (NSString *) evaluateRook:(TDMChessMove *)move
{
    BOOL isXPosEqual = move.endingXPos == move.startXPos;
    BOOL isYPosEqual = move.endingYPos == move.startYPos;
    
    if (isXPosEqual || isYPosEqual)
    {
        return @"LEGAL - ROOK";
    }
    else return @"ILLEGAL - ROOK";
}


//|X2 ‐ X1| =|Y2 ‐ Y1|.


@end
