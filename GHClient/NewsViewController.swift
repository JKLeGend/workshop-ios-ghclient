//
//  ViewController.swift
//  ghclient-ios
//
//  Created by Xin Guo  on 2018/10/28.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private let events: [Event] = FakeDataProvider().providerData()
  
  private let reuseIdentifier = "NewsTableViewCell"
  private let networkclient = AlamofireNetworkClient()
  private let url = "https://api.github.com/users/JKLeGend/received_events"

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    let header =  RequestHeaderBuilder()
        .configure(username: "JKLeGend")
        .configure(password: "")
        .build()
    networkclient.get(url: URL(string: url)!, header: header) { (json, error) in
    }
  }
}

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NewsTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(with: events[indexPath.row])
    return cell
  }
}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
  }
}
