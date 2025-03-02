//
//  AdressTableViewCell.swift
//  EDS_Store
//
//  Created by Илья Морозов on 20.02.2025.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    var numberLabel = UILabel()
    
    var adressTF = UITextField()
    
    static let identifier = "adressCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        setupAdress()
        setupNumber()
    }
    
    //MARK: - CONFIGURE ADDRESS
    func setupAdress() {
        adressTF.placeholder = "Новый Адресс"
        adressTF.textColor = .black
        adressTF.adjustsFontSizeToFitWidth = true
        adressTF.minimumFontSize = 10// Минимальный масштаб шрифта (50% от исходного размера)
        adressTF.delegate = self
        adressTF.textAlignment = .right
        adressTF.font = .systemFont(ofSize: 20, weight: .medium)
        adressTF.frame = CGRect(x: contentView.bounds.width * 0.4, y: contentView.bounds.height * 0.5,
                                 width: contentView.bounds.width*0.57, height: contentView.bounds.height * 0.8)
        contentView.addSubview(adressTF)
    }
    
    //MARK: - CONFIGURE NUMBER
    func setupNumber() {
        numberLabel.font = .systemFont(ofSize: 20, weight: .medium)
        numberLabel.textAlignment = .left
        numberLabel.textColor = .black
        numberLabel.frame = CGRect(x: contentView.bounds.width * 0.02, y: contentView.bounds.height * 0.5, width: contentView.bounds.width*0.35, height: contentView.bounds.height * 0.8)
        contentView.addSubview(numberLabel)
    }
    
    
    func setupNumber(number: Int) {
        numberLabel.text = "Адрес № \(number+1)"
    }
    
    //MARK: - SETUP ADDRESS
    func setupAddress(address: String) {
        adressTF.text = address
    }

}


extension  AddressTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
