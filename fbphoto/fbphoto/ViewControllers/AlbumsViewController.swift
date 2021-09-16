//
//  AlbumsViewController.swift
//  fbphoto
//
//  Created by Гость on 16.09.2021.
//

import UIKit
import FacebookCore

class AlbumsViewController: UIViewController {
    
    let tableView = UITableView()
    let cellIdentifier = "AlbumTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addTableView()
        
        let request = GraphRequest(graphPath: "/me/albums")
        request.start { connection, result, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
            }
            if let result = result as? [String: Any] {
                if let data = result["data"] {
                    print("\(data)") // нужно распарсить
                }
            }
        }
    }
    
    func addTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell.textLabel?.text = String(indexPath.item)
        return cell
    }
}
