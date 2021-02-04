//
//  DetailedViewController.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 02/02/2021.
//

import UIKit

class DetailedViewController: UIViewController {
    //MARK: - PARAMS
    weak var coordinator: MainCoordinator?
    
    var currancyData_DateArray = [DetailedViewModel]()
    var passedName = ""
    var currencyPassedSymbol = ""
    var dataArray = [String]()
    var valueArray = [Double]()
    var sorteddataArray = [String]()
    var sortedvalueArray = [Double]()
    let tableView: UITableView = UITableView()
    let date = Date()
    let formatter = DateFormatter()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let datetime = formatter.string(from: date)
        let endData = datetime
        let startDate = BackToPreviousMonday()
        //start date is always previous one
        GETHitoricalPLN(from: startDate, to: endData, currency: passedName)
    }
    
//MARK: - Function & Networking
    func GETHitoricalPLN(from: String, to: String, currency cur: String){
        // %Y-%m-%d
        let url = URL(string: "https://api.exchangeratesapi.io/history?start_at=\(from)&end_at=\(to)&base=PLN&symbols=\(cur)")
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let rates = json["rates"] as? [String: [String : Double]]{
                    for elements in 0...Array(rates).count-1{
                        
                        let dataN = Array(rates)[elements].key
                        var valueN = String((rates)[dataN]![passedName] ?? 0)
                        valueN += " \(passedName.currencySymbol)"
                        // data to array
                        self.currancyData_DateArray.append(contentsOf: [DetailedViewModel(currency: .init(data: dataN, value: valueN))])
                    }
                }
                currancyData_DateArray.sort {$0.name < $1.name}
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    // func to get to previous monday
    private func BackToPreviousMonday() -> String{
        let dataToWhich = Date.today().previous(.monday)
        let previous = dataToWhich - 7
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let datetime = formatter.string(from: previous)
        return datetime
    }
    
//MARK: - UI Setup
    
    //setup UI - bar buttons, title etc.
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        
        if self.traitCollection.userInterfaceStyle == .dark {
            navTitle.textColor = .white
        }
        
        navTitle.text = "\(passedName) currency to previus Monday : "
        setupTitle()
        setupTableView()
    }
    
    let navTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        label.text = ""
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailedTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTitle() {
        view.addSubview(navTitle)
        navTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        navTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        navTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        navTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
//MARK: - TableView
extension DetailedViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currancyData_DateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailedTableViewCell
        cell.selectionStyle = .none
        cell.detailedViewModel = currancyData_DateArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}




