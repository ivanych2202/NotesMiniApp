//
//  File.swift
//  
//
//  Created by Ivan Elonov on 07.09.2024.
//

import UIKit
import RealmSwift

public class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    
    var notes: Results<Note>?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
        
        setupUI()
        loadNotes()
    }

    private func loadNotes() {
        notes = DataManager.shared.getAllNotes()
        tableView.reloadData()
    }
    
    private func setupUI() {
        addNoteButton.layer.cornerRadius = addNoteButton.frame.width / 2
        addNoteButton.setTitle("", for: .normal)
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
    }
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNoteButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Новая заметка", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Текст заметки"
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            guard let text = alertController.textFields?[0].text else {
                return
            }
            
            let newNote = Note()
            newNote.text = text
            
            DataManager.shared.addNewNote(note: newNote)
            self?.loadNotes()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        if let note = notes?[indexPath.row] {
            cell.textLabel?.text = note.text
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let note = notes?[indexPath.row] else { return }
        
        let alertController = UIAlertController(title: "Изменить заметку", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.text = note.text
            textField.placeholder = "Текст заметки"
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            guard let newText = alertController.textFields?[0].text else {
                return
            }
            
            DataManager.shared.editNote(note: note, newText: newText)
            self?.loadNotes()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let note = notes?[indexPath.row] {
                DataManager.shared.deleteNote(note: note)
                loadNotes()
            }
        }
    }
}

