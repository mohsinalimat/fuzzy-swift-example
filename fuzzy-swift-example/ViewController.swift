//
//  ViewController.swift
//  fuzzy-swift-example
//
//  Created by khoi on 8/9/19.
//  Copyright © 2019 khoi. All rights reserved.
//

import UIKit
import Fuzzy

class ViewController: UIViewController, UISearchBarDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  private lazy var dataSource = makeDataSource()
  
  private let data = [
    "Package.swift",
    "README.md",
    "Sources",
    "Sources/Fuzzy",
    "Sources/Fuzzy/Fuzzy.swift",
    "Tests",
    "Tests/FuzzyTests",
    "Tests/FuzzyTests/FuzzyTests.swift",
    "Tests/FuzzyTests/XCTestManifests.swift",
    "Tests/LinuxMain.swift",
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = dataSource
    searchBar.delegate = self
    update(with: data)
  }
  
  func update(with list: [String], animate: Bool = true) {
      let snapshot = NSDiffableDataSourceSnapshot<Int, String>()
      snapshot.appendSections([1])
      snapshot.appendItems(list)
      dataSource.apply(snapshot, animatingDifferences: animate)
  }
  
  func makeDataSource() -> UITableViewDiffableDataSource<Int, String> {
    return UITableViewDiffableDataSource(
      tableView: tableView,
      cellProvider: { tableView, indexPath, text in
        let cell = tableView.dequeueReusableCell(
          withIdentifier: "cell",
          for: indexPath
        )
        cell.textLabel?.text = text
        return cell
    }
    )
  }
  
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    update(with: data.filter { search(needle: searchText, haystack: $0) } )
   }
}
