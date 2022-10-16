//
//  EmojiTableViewController.swift
//  TableViewProject
//
//  Created by Bakhtiyarov Fozilkhon on 02.10.2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    var objects = [
        Prezident(image: UIImage(named: "Ronaldu")!, name: "Cristiano Ronaldu", description: "8707-140-00-00", isFavourite: false),
        Prezident(image: UIImage(named: "Messi")!, name: "Leo Messi", description: "8707-140-00-00", isFavourite: false),
        Prezident(image: UIImage(named: "Mohamed")!, name: "Mohammed Salah", description: "8707-140-00-00", isFavourite: false),
        Prezident(image: UIImage(named: "Neymar")!, name: "Jr Neymar", description: "8707-140-00-00", isFavourite: false),
        Prezident(image: UIImage(named: "Mbappe")!, name: "Killian Mbappe", description: "8707-140-00-00", isFavourite: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The Best football players"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSeque(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        }else{
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
        self.title = "The Best football players"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationVc = segue.destination as! UINavigationController
        let newEmojiVc = navigationVc.topViewController as! NewEmojiTableViewController
        newEmojiVc.emoji = emoji
        newEmojiVc.title = "Edit"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)

        return cell
    }
  
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = objects[indexPath.row]
        if editingStyle == .delete{
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if objects.count == 0 {
                self.title = "There is no more contacts"
            }
            let alert = UIAlertController(title: "", message: "You removed \(object.name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let like = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [like])
    }

    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Liked") { (action, view, comletion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            comletion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        if action.backgroundColor == .systemPurple {
            let alert = UIAlertController(title: "", message: "You liked for \(object.name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        action.image = UIImage(systemName: "heart")
        return action
    }
}
