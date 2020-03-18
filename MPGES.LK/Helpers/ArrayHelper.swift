//
//  ArrayHelper.swift
//  mpges.lk
//
//  Created by Timur on 05.03.2020.
//  Copyright © 2020 ChalimovTimur. All rights reserved.
//

extension Sequence {
    
    func groupBy<G: Hashable>(closure: (Iterator.Element)->G) -> [G: [Iterator.Element]] {
        var results = [G: Array<Iterator.Element>]()
        
        forEach {
            let key = closure($0)
            
            if var array = results[key] {
                array.append($0)
                results[key] = array
            }
            else {
                results[key] = [$0]
            }
        }
        
        return results
    }
    
}
