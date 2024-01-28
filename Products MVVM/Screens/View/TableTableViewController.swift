//
//  TableTableViewController.swift
//  Products MVVM
//
//  Created by Prashantdan on 22/01/24.
//

import UIKit

class Response: Codable{
    let count: Int?
    let results: [Film]
}
 
 
class Film: Codable{
    let title: String?
    let episode_id: Int?
    let opening_crawl : String?
    
    init(title:String, episode_id:Int, opening_crawl: String) {
        self.title = title
        self.episode_id = episode_id
        self.opening_crawl = opening_crawl
    }
}

struct Book: Decodable {

    let title: String
    let author: String

}

class TableTableViewController: UITableViewController {

    private var films: [Film]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://bit.ly/3sspdFO")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let books = try? JSONDecoder().decode([Book].self, from: data) {
                            print(books)
                        } else {
                            print("Invalid Response")
                        }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode  else {
                return
            }

        }
        task.resume()
//        self.fetchFilms(completionHandler: (films) in self.films = films)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tableviewheight = self.tableView.frame.height
        let contentheight = self.tableView.contentSize.height
        
        let centeringInset = (tableviewheight - contentheight)/2.0
        let topinset = max(centeringInset, 0.0)
        self.tableView.contentInset = UIEdgeInsets(top: topinset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    func fetchFilms(completionHandler: @escaping([Film]) -> Void){
        let url = URL(string: "https://swapi.dev/api/films/")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler:{(data,response,error) in
            if let error = error {
                print("error with fetching films: \(error)")
                return
            }
            
           guard let httpResponse = response as? HTTPURLResponse,
                 (200...299).contains(httpResponse.statusCode) else{
               print("Error with the response, unexpected status code: \(response)")
                       return
           }
            
           if let data = data,
              let filmSummary = try? JSONDecoder().decode(Response.self, from: data){
               completionHandler(filmSummary.results)
           }
        })
        
        task.resume();
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
