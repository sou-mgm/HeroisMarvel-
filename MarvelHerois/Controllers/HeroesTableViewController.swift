//
//  HeroesTableViewController.swift
//  MarvelHerois
//
//  Created by Matheus Matias on 26/12/22.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var name: String?
    var heroes: [Hero] = []
    // para evitar que o usuario faca uma nova solicitacao antes da primeira ter carregado
    var loadingHeroes: Bool = false
    //pagina atual
    var currentPage: Int = 0
    // Criterio para saber se chegou-se no final da requisicao
    var total: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Buscando, aguarde..."
        loadHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HeroViewController
        vc.hero = heroes[tableView.indexPathForSelectedRow!.row]
    }
    
    func loadHeroes(){
        loadingHeroes = true
        
        MarvelAPI.loadHeros(name: name, page: currentPage) { (info) in
            if let info = info {
                // add os herois no array
                self.heroes += info.data.results
                self.total = info.data.total
                print("Total: ",self.total," - Já incluidos: ",self.heroes.count)
                
                DispatchQueue.main.async {
                    self.loadingHeroes = false
                    self.label.text = "Não foram encontrados heróis com este nome \(self.name!)"
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heroes.count == 0 ? label : nil
        return heroes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell
        let hero = heroes[indexPath.row]
        cell.prepareCell(with: hero)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Se o usuario chegar proximo do final da pagina e nao houver uma requisicao anterior, e se o table tiver um numero diferente do total, ele carrega mais herois
        if indexPath.row == heroes.count - 15 && !loadingHeroes && heroes.count != total{
            currentPage += 1
            loadHeroes()
            print("Carregando mais herois")
        }
        
    }
    
}

    
