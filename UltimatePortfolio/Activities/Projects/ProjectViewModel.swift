//
//  ProjectViewModel.swift
//  UltimatePortfolio
//
//  Created by Andrey Mikhaylin on 16.09.2021.
//

import Foundation
import CoreData

extension ProjectsView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        var sortOrder = Item.SortOrder.optimized
        let showClosedProjects: Bool
        
        private let projectsController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()
        
        let dataController: DataController
        @Published var showingUnlockView = false
        
        func addItem(to project: Project) {
            let item = Item(context: dataController.container.viewContext)
            item.priority = 2
            item.completed = false
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }
        
        func addProject() {
            if dataController.addProject() == false {
                showingUnlockView.toggle()
            }
        }
        
        func delete(_ offsets: IndexSet, from project: Project) {
            let allItems = project.projectItems(using: sortOrder)
            
            for offset in offsets {
                let item = allItems[offset]
                dataController.delete(item)
            }
            
            dataController.save()
        }
        
        init(dataController: DataController, showClosedProjects: Bool) {
            self.dataController = dataController
            self.showClosedProjects = showClosedProjects
            
            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: "closed = %d", showClosedProjects)
                                       
            projectsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            super.init()
            projectsController.delegate = self
            
            do {
                try projectsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
            } catch {
                fatalError("Failed to fetch projects")
            }
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
    }
}
