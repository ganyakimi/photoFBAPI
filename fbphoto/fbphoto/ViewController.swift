//
//  ViewController.swift
//  fbphoto
//
//  Created by Гость on 13.09.2021.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let loginButton = FBLoginButton()
        loginButton.permissions = ["user_photos"]
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        let albumsButton = UIButton(type: .system)
        albumsButton.setTitle("Открыть альбом", for: .normal)
        albumsButton.addTarget(self, action: #selector(handleAlbumButton(_:)), for: .touchUpInside)
        view.addSubview(albumsButton)
        
        albumsButton.translatesAutoresizingMaskIntoConstraints = false
        albumsButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        albumsButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        
        //let photoButton = UIButton(type: .system)
    }
    
    @objc func handleAlbumButton(_ sender: UIButton) {
        if AccessToken.current != nil {
            navigationController?.pushViewController(AlbumsViewController(), animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Войдите в Facebook", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
            present(alert, animated: true)
        }
    }
    @objc func handlePhotoButton (_ sender: UIButton){
        if AccessToken.current != nil{
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}

extension ViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("logged in")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logged out")
    }
}

