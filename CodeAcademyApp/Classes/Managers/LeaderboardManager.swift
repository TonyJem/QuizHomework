//
//  LeaderboardManager.swift
//  CodeAcademyApp
//
//  Created by Lukas Uscila Dainavicius on 21/01/2021.
//

import Foundation

struct LeaderboardManager {
    
    static var scoreRows: [ScoreRow] {
        guard let gameSaves = UserDefaultsManager.gameSaves else { return []}
        var scoreRows = [ScoreRow]()
        for gameSave in gameSaves {
            scoreRows.append(ScoreRow(name: gameSave.username, points: String(gameSave.score)))
        }
        scoreRows.sort { (firstRow, secondRow) -> Bool in
            return firstRow.points > secondRow.points
        }
        return scoreRows
    }
}
