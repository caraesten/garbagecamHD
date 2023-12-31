//
//  TileCaptureProcessor.swift
//  GarbageCam
//
//  Created by Esten Hurtle on 9/16/16.
//  Copyright © 2016 Esten Hurtle. All rights reserved.
//

import Foundation
import GameKit

class TileCaptureProcessor: CaptureProcessor {
    let mRows: Int
    let mColumns: Int
    
    // Allows for random frame capture: each element in the array corrsponds to a frame. Index = index in non-random orders.
    let mFrameMappings: [Int]
    
    init(columns: Int, rows: Int, mappings: [Int]) {
        mRows = rows
        mColumns = columns
        mFrameMappings = mappings
    }
    
    override func getCaptureHeight(_ bufHeight: Int) -> Int {
        return bufHeight / mRows
    }
    
    override func getCaptureWidth(_ bufWidth: Int) -> Int {
        return bufWidth / mColumns
    }
    
    override func getCaptureOffsetX(_ frameNumber: Int, bufWidth: Int, bufHeight: Int) -> Int {
        let mappedNumber = mFrameMappings[frameNumber]
        let imgWidth = getCaptureWidth(bufWidth)
        return imgWidth * (mappedNumber % mColumns)
    }
    
    override func getCaptureOffsetY(_ frameNumber: Int, bufWidth: Int, bufHeight: Int) -> Int {
        let mappedNumber = mFrameMappings[frameNumber]
        let imgHeight = getCaptureHeight(bufHeight)
        let curRow = mappedNumber / mColumns
        return min(curRow * imgHeight, bufHeight - imgHeight)
    }
    
    override func getMaxSize() -> Int {
        return mColumns * mRows
    }
    
    override func getProgress(_ frameCount: Int) -> Float {
        return Float(frameCount) / Float(mColumns * mRows)
    }
}
