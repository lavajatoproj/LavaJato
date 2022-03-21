//
//  FiltroViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 13/03/22.
//

import UIKit

class FiltroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func callMaps(_ sender: Any) {
        performSegue(withIdentifier: "maps", sender: nil)
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
