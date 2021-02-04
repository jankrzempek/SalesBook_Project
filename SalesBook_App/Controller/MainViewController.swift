//
//  ViewController.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 02/02/2021.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    //MARK: - PARAMS
    weak var coordinator: MainCoordinator?
    var currancyDataArray = [MainViewModel]()
    var name = [String]()
    var value = [String]()
    var dataOfGET = ""
    let tableView: UITableView = UITableView()
    var choosenTitle = ""
    var imagePath = ""
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupTableView()
        GETPLNMethod(currency: "PLN")
    }
    
    //MARK: - RightBarButton_Actions
    
    @IBAction func rightButtonAction(sender: UIBarButtonItem) {
        
        for index in 0...currancyDataArray.count-1{
            name.append(currancyDataArray[index].name)
        }
        // If You do not move in data picker the first one will be default
        choosenTitle = name[0]
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 150)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: -50, width: 250, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        
        let alert = UIAlertController(title: "Please choose main currency:", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { response in
            self.navigationItem.title = "1 \(self.choosenTitle) is worth:"
            self.GETPLNMethod(currency: self.choosenTitle)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
//MARK: - LeftBarButton_Actions
    
    @IBAction func settings(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "NEW FEATURE - settings!", message: "Unfortunetly it won't be realeased until future update", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
//MARK: - Functions & Networking
    func GETPLNMethod(currency: String){
        // clear to prevent copying
        clear()
        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=\(currency)")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            // Convert HTTP Response Data to a simple String
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let rates = json["rates"] as? [String: Double]{
                    self.dataOfGET = (json["date"]) as! String
                    
                    for elements in 0...Array(rates).count-1{
                        let nameN = String(Array(rates)[elements].key)
                        var valueN = String(Array(rates)[elements].value)
                        valueN += " \(nameN.currencySymbol)"
                        // preapering an image name with extension to future download
                        let PathOfFile = ".jpg"
                        let nameOfPathFile = nameN
                        let fullPath = nameOfPathFile + PathOfFile
                        // appending to array
                        self.currancyDataArray.append(contentsOf: [MainViewModel(currency: .init(name: nameN, value: valueN, imageURL: fullPath))])
                    }
                    self.currancyDataArray.sort {$0.name < $1.name}
                }
            }
            DispatchQueue.main.async{
                self.navigationItem.title = "1 \(currency) is worth:"
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
//to clear and not meesup with Data
    private func clear() {
        self.value = []
        self.name = []
        self.currancyDataArray = []
    }
    
//MARK: - SETUP UI
// setuups UI - bar buttons and title
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Welcome, loading..."
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "dollarsign.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(rightButtonAction))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "gearshape")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(settings))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(StaticTableViewCell.self, forCellReuseIdentifier: "Staticcell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TableView
extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currancyDataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Staticcell") as! StaticTableViewCell
            // selection set to none becouse it only shows date
            cell.selectionStyle = .none
            cell.date.text = "Currencies for Date: "
            cell.title.text = dataOfGET
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            cell.selectionStyle = .default
            cell.mainViewModel = currancyDataArray[indexPath.row-1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
            if selectedIndexPath.row >= 1{
                let nameOfCurrentCell = currancyDataArray[indexPath.row-1].name
                let currencySymoblname = currancyDataArray[indexPath.row-1].name.currencySymbol
                
                coordinator?.presentDetailedView(name: nameOfCurrentCell, currency: currencySymoblname)
            }
        }
    }
}

//MARK: - PickerView
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return name.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return name[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        choosenTitle = name[row]
    }
}


