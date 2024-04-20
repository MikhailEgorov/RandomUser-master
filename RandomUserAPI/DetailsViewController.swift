//
//  DetailsViewController.swift
//  RandomUserAPI
//
//  Created by Егоров Михаил on 26.02.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var userImageView: UIImageView! {
        didSet {
            userImageView.layer.cornerRadius = userImageView.frame.height / 2
        }
    }
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var moreInfoLabel: UILabel!
    
    var result: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues(with: result)
    }

        private func setValues(with result: User) {
            if let imageURL = result.picture?.large {
                NetworkManager.shared.fetchData(from: imageURL) { imageData in
                    self.userImageView.image = UIImage(data: imageData)
                }
            }
            
            firstNameLabel.text = result.name?.first
            lastNameLabel.text = result.name?.last
            moreInfoLabel.text = """
            More Info:
                Username: \(result.login?.username ?? "")
                Age: \(result.dob?.age ?? 999)
                Email: \(result.email ?? "")
                Country: \(result.location?.country ?? "")
                
            """
        }
    }
