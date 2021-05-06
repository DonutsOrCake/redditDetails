//
//  PostListTableViewController.swift
//  redditDetails
//
//  Created by Bryson Jones on 5/5/21.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPostsForTableView()
    }
    
    //MARK: - Properties
    var posts: [Post] = []
    
    //MARK: - Functions
    func fetchPostsForTableView() {
        PostController.fetchPosts { (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        let post = posts[indexPath.row]
        cell?.post = post
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetailVC" {
//            let cell = sender as! PostTableViewCell
//            let vc = segue.destination as! PostDetailViewController
//        }
//    }
}//End of class
