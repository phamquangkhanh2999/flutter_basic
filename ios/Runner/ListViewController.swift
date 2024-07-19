import UIKit

class ListViewController: UIViewController {
    var onDataFetched: (([String]) -> Void)?

    private let dataList: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.view.addSubview(tableView)

        // Giả sử dữ liệu được tải xong sau 2 giây
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.onDataFetched?(self.dataList)
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
}
