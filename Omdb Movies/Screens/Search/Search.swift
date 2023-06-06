//
//  Search.swift
//  Omdb Movies
//
//  Created by na on 5.06.2023.
//  Copyright © 2023 @ Numan Ayhan. All rights reserved.
//

import UIKit
import TinyConstraints

class Search: Base {
    var search = UISearchController()

    lazy var sectionView :BaseCollectionView = {
        return BaseCollectionView(frame: .zero)
    }()
    lazy var searchView :BaseTableView = {
        return BaseTableView(frame: .zero)
    }()
    var worker: MoviesListWorker? = {
        return MoviesListWorker()
    }()
    lazy var scrollableView : ScrollableStackView = {
        let view = ScrollableStackView()
        view.spacing = 40
        return view
    }()

    var searchList : [MoviesResult]?
    
    var searchParams = "" {
        didSet{
            getSeachList(searchParams)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
    }
    func setLayout() {
        getComedyList()
        searchParams = "Star"
        setSearchNavbar()
        setCollectionListView()
    }
    
    func setCollectionListView() {
        view.backgroundColor = .white
        scrollableView.backgroundColor = .white
        scrollableView.stackView.distribution = .fillProportionally
        scrollableView.stackView.alignment = .center
        searchView.delegate = self
        scrollableView.stackView.addArrangedSubview(searchView)
        searchView.anchor( top: scrollableView.stackView.topAnchor, left: scrollableView.stackView.leftAnchor,
            bottom: nil, right: scrollableView.stackView.rightAnchor,
            paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,
            width: self.view.frame.width, height: 400)

        scrollableView.stackView.addArrangedSubview(sectionView)
        sectionView.anchor(
            top: searchView.bottomAnchor, left: scrollableView.stackView.leftAnchor,
            bottom: nil, right: scrollableView.stackView.rightAnchor,
            paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,
            width: self.view.frame.width, height: view.frame.height / 2 )
        
        view.addSubview(scrollableView)
        scrollableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)

    }

    func getComedyList() {
        worker?.fetchSearchMovieList(searchParams:"comedy", completion: { [weak self] result in
            guard self != nil else { return }
            let response = ResponseHandler.validatedResponse(result, dismissOnFailure: false)
            let viewModel = MoviesVM(
                size: CGSize(width: 240, height: 160),
                sectionInset: .init(top: 12, left: 12, bottom: 12, right: 12),
                minimumLineSpacing:12,
                minimumInteritemSpacing: 12,
                numberOfItems: response.search!.count,
                title: "Comedy",
                lists: response.search
            )
            self?.sectionView.data = viewModel
            self?.sectionView.collectionView.reloadData()
        })
    }

    func getSeachList(_ sender:String){
        worker?.fetchSearchMovieList(searchParams:sender,completion: { [weak self] result  in
            guard self != nil else { return }
            let response = ResponseHandler.validatedResponse(result, dismissOnFailure: false)
            if response.search != nil  {
                let viewModel = MoviesVM(
                    size: CGSize(width: 240, height: 160),
                    sectionInset: .init(top: 12, left: 12, bottom: 12, right: 12),
                    minimumLineSpacing:12,
                    minimumInteritemSpacing: 12,
                    numberOfItems: response.search!.count,
                    title: sender,
                    lists: response.search
                )
                self?.searchView.data = viewModel
                self?.searchView.tableView.reloadData()
            }
        })
    }
}

extension Search:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        if searchText.count >= 3 {
            searchParams = searchText
        }
    }
}

extension Search: BaseTableViewDelegate {

    func didSelect(index: Int, data:MoviesResult) {
        let vc = Detail()
        vc.indexSelected = index
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension Search {
    func setSearchNavbar(){
        if navigationController != nil{
            search.obscuresBackgroundDuringPresentation = false
            navigationController?.navigationBar.isHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationItem.setHidesBackButton(true, animated: true)
            navigationItem.searchController = UISearchController(searchResultsController: self)
            search = UISearchController(searchResultsController: nil)
            search.searchResultsUpdater = self
            search.obscuresBackgroundDuringPresentation = true
            search.searchBar.placeholder = "Searching Movies"
            search.searchBar.delegate = self
            search.searchBar.selectedScopeButtonIndex = 0
            search.searchBar.scopeButtonTitles = MoviesCategory.Category.allCases.map { $0.rawValue }
            definesPresentationContext = true
            navigationItem.searchController = search
            navigationItem.hidesSearchBarWhenScrolling = false
            self.navigationController?.navigationBar.backItem?.title = " "
            navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.navigationBar.backIndicatorImage = UIImage()
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
            self.navigationController!.navigationBar.tintColor  = .black
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
            self.navigationController?.navigationBar.prefersLargeTitles = true
            titleLabelText = "Movies"
            self.navigationItem.title = titleLabelText
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:  UIColor.black]
        }
    }
}
