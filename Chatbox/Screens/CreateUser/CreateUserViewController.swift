//
//  CreateUserViewController.swift
//  Chatbox
//
//  Created by Afnan Ahmed on 25/01/2024.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    var dailCode = ""
    var sections: [String] = []
    var sectionData: [String: [String]] = [:]
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var contriesTableView: UITableView!
    var viewModel: CreateUserViewModel!
    var countrieslist: Countries!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        activityIndicator.isHidden = true
        // Do any additional setup after loading the view.
        countrieslist = Countries()
        configureTableView()
        getCCurrentLocation()
       
    }
    
    @IBAction func SendButtonClick(_ sender: Any) {
        if dailCode != "" && numberTextField.text != "" {
            let temp = numberTextField.text ?? ""
            let number = dailCode + temp
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            sendButton.alpha = 0.25
            viewModel.requestAuthenticate(number: number)
        }
        
    }
    
    @IBAction func countryCodeButtonClick(_ sender: Any) {
        if contriesTableView.isHidden == true {
            contriesTableView.isHidden = false
        } else {
            contriesTableView.isHidden = true
        }
        
    }
    
    func getCCurrentLocation() {
        var code = ""
        if let currentLocale = Locale.current.regionCode {
            print("Current Country Code: \(currentLocale)")
            code = currentLocale
        }
        for country in countrieslist.allCountries {
            if country.code == code {
                dailCode = country.dialCode
                setCountyCode(code: country.code, dail: country.dialCode)
            }
        }
    }
    
    func setCountyCode(code: String, dail: String) {
        dailCode = dail
        countryCodeButton.setTitle("\(code), \(dail)", for: .normal)
        contriesTableView.isHidden = true
    }
}

extension CreateUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        
        let country : [Country] = countrieslist.allCountries
        var sortedData = ["",""]
        sortedData = []
        for country in country {
            sortedData.append(country.name)
        }
        for item in sortedData {
            let firstLetter = String(item.prefix(1))
            if sectionData[firstLetter] == nil {
                sections.append(firstLetter)
                sectionData[firstLetter] = [item]
            } else {
                sectionData[firstLetter]?.append(item)
            }
        }
        contriesTableView.delegate = self
        contriesTableView.dataSource = self
        contriesTableView.register(UINib(nibName: "CountriesTableViewCell", bundle: .main), forCellReuseIdentifier: "CountriesTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionLetter = sections[section]
        return sectionData[sectionLetter]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountriesTableViewCell", for: indexPath) as! CountriesTableViewCell
        let sectionLetter = sections[indexPath.section]
        let rowData = sectionData[sectionLetter]![indexPath.row]
        let country : [Country] = countrieslist.allCountries
        for country in country {
            if country.name == rowData {
                cell.setUPCell(contry: country)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionLetter = sections[indexPath.section]
        let rowData = sectionData[sectionLetter]![indexPath.row]
        let country : [Country] = countrieslist.allCountries
        for country in country {
            if country.name == rowData {
                setCountyCode(code: country.code, dail: country.dialCode)
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}

extension CreateUserViewController: UITextFieldDelegate {
    func configureFields() {
        numberTextField.delegate = self
    }

    // MARK: - UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

         let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
         
         // Check if the first character is not an empty space or if the entire text is empty
         if updatedText.isEmpty || !CharacterSet.whitespaces.contains(updatedText.first!.unicodeScalars.first!) {
             // The first character is not an empty space, or the text is empty
             return true
         } else {
             // The first character is an empty space, prevent the change
             return false
         }
     }
}
