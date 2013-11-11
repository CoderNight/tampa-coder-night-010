//
//  TDMChessMove.h
//  ChessValidator
//
//  Created by Craig Clayton on 10/29/13.
//  Copyright (c) 2013 Craig Clayton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDMChessMove : NSObject

@property (strong, nonatomic) NSString* moves;
@property (strong, nonatomic) NSString* startMove;
@property (strong, nonatomic) NSString* endingMove;
@property (nonatomic) int startXPos;
@property (nonatomic) int startYPos;
@property (nonatomic) int endingXPos;
@property (nonatomic) int endingYPos;

- (id) initWithMoves:(NSString *)move;

@end
