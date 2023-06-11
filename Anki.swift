//
//  Anki.swift
//  free-anki
//
//  Created by Roman Yaremko on 09.06.2023.
//

import Foundation

struct Anki {
    var id = UUID()
    var word = ""
    var reading = ""
    var meaning = ""
    
    init(id: UUID = UUID(), raw: [String]) {
        self.id = id
        self.word = raw[0].trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        self.reading = raw[1].trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        self.meaning = raw[2...].joined(separator: ",").trimmingCharacters(in: CharacterSet(charactersIn: "\"\\"))
    }
}

func loadCsv(from csvName: String) -> [Anki] {
    var csvToStruct = [Anki]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return []
    }
    
    var data = ""
    
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return []
    }
    
    var rows = data.components(separatedBy: "\n")
    
    rows.removeFirst()
    
    for row in rows {
        if row == "" {
            continue
        }
        let csvColumns = row.components(separatedBy: ",")
        let tmp = Anki.init(raw: csvColumns)
        csvToStruct.append(tmp)
    }
    
    return csvToStruct
}
