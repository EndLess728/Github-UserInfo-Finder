//
//  ViewController.swift
//  Github UserInfo Finder
//
//  Created by MacMini on 9/20/18.
//  Copyright © 2018 com.thisislit. All rights reserved.
//

import UIKit

struct MyGithub: Codable {
    let name:String?
    let followers:Int?
    let location:String?
    let public_repos:Int?
    let avatar_url:URL?
    

    
}

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var followersTitle: UILabel!
    @IBOutlet weak var repoTitle: UILabel!
    

    
    @IBAction func findUserButton(_ sender: Any) {
        
        let userText = usernameTextField.text
        
        guard let gitUrl = URL(string: "https://api.github.com/users/" + userText!) else {return}
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            
            guard let data = data else {return}
            do {
                
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGithub.self, from: data)
                
                DispatchQueue.main.sync {
            
                    if let gimage = gitData.avatar_url{
                        let data = try? Data(contentsOf: gimage)
                        let image: UIImage = UIImage(data: data!)!
                        self.userImageView.image = image
                    }
                    
                    if let gname = gitData.name{
                        self.nameLabel.text = gname
                    }
                    
                    if let glocation = gitData.location {
                        self.locationLabel.text = glocation
                    }
                    
                    if let gfollowers = gitData.followers {
                        self.followerLabel.text = String(gfollowers)
                    }
                    
                    if let grepos = gitData.public_repos{
                        self.repoLabel.text = String(grepos)
                    }
                }
                
                
                    
                    
                }
                
            catch let err {
                print("Err", err)
            
        }
        
    }.resume()
        setLabelStatus(value: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelStatus(value: true)
        
        
}
    func setLabelStatus(value: Bool) {
        nameLabel.isHidden = value
        locationLabel.isHidden = value
        followerLabel.isHidden = value
        repoLabel.isHidden = value
        userImageView.isHidden = value
        nameTitle.isHidden = value
        locationTitle.isHidden = value
        repoTitle.isHidden = value
        followersTitle.isHidden = value
        
        
    }




}
