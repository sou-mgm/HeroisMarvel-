//
//  SearchViewController.swift
//  MarvelHerois
//
//  Created by Matheus Matias on 26/12/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HeroesTableViewController
     
        vc.name = tfName.text!
        
    }

}
