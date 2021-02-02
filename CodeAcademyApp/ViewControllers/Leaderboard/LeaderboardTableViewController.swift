import UIKit

struct ScoreRow {
    let name: String
    let points: String
}

class LeaderboardTableViewController: UITableViewController {

    var scores = [ScoreRow]()

    override func viewDidLoad() {
        super.viewDidLoad()
        scores = LeaderboardManager.scoreRows
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
        let scoreRow = scores[indexPath.row]
        cell.textLabel?.text = scoreRow.name
        cell.detailTextLabel?.text = scoreRow.points

        return cell
    }
}
