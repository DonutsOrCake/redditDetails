//
//  PostTableViewCell.swift
//  redditDetails
//
//  Created by Bryson Jones on 5/5/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postSubredditLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Functions
    func updateViews() {
        
        guard let post = post else {return}
        postTitleLabel.text = post.title
        postSubredditLabel.text = post.subreddit_name_prefixed
        
        PostController.fetchThumbnail(post: post) { (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let thumbnail):
                    self.postImageView.image = thumbnail
                    
                case .failure(let error):
                    self.postImageView.image = UIImage(named: "noThumbnail")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}//End of class
