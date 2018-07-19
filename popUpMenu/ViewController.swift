//
//  ViewController.swift
//  popUpMenu
//
//  Created by Noah Schairer on 7/17/18.
//  Copyright © 2018 nschairer. All rights reserved.
//

import UIKit


protocol selectedDirectorProtocol {
    func selectedDirector(string: String)
}
class ViewController: UIViewController, selectedDirectorProtocol {

    @IBOutlet weak var menuBtn: UIButton!
    var menu = popUpMenu()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func selectedDirector(string: String) {
        menuBtn.setTitle(string, for: .normal)
    }
    
    @IBAction func showMenu(_ sender: Any) {
       menu.animate()
    }
    
    
    func initialize() {
        let frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width/2, height: self.view.frame.height/2)
        menu = popUpMenu.init(frame: frame)
        menu.delegate = self
        menu.center = self.view.center
        let arr = ["Monday", "Tuesday","Wednesday", "Thursday", "Friday"]
        menu.datasource = arr
        self.view.addSubview(menu)
        menu.tableView.reloadData()
        menu.isHidden = true
    }
    
}


class popUpMenu: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var datasource = [String]()
    var tableView = UITableView()
    var delegate: selectedDirectorProtocol!

    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.addSubview(tableView)
    }
    override func didMoveToSuperview() {
        tableView.frame = self.bounds
        tableView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2705882353, blue: 0.3098039216, alpha: 1).withAlphaComponent(0.5)
        tableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView.layer.cornerRadius = 8
        tableView.separatorInset.left = 8
        tableView.separatorInset.right = 8
    }
    
    func animate() {
        self.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finshed) in
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datasource[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.selectedDirector(string: datasource[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        self.isHidden = true
    }
    
    
}

