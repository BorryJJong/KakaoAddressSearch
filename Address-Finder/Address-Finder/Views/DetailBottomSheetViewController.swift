//
//  DetailBottomSheetViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/09/08.
//

import UIKit

class DetailBottomSheetViewController: UIViewController {

  private let dimmedView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.darkGray.withAlphaComponent(0)
         return view
     }()
  private let bottomSheetView: UIView = {
          let view = UIView()
          view.backgroundColor = .white

          // 좌측 상단과 좌측 하단의 cornerRadius를 10으로 설정한다.
          view.layer.cornerRadius = 10
          view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
          view.clipsToBounds = true
          return view
      }()
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
     // 2
     override func viewDidLoad() {
         super.viewDidLoad()
         setupUI()
     }

     // 3
     private func setupUI() {
      view.addSubview(dimmedView)
       view.addSubview(bottomSheetView)

       setupLayout()
     }

     // 4
     private func setupLayout() {
         dimmedView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
             dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
         bottomSheetView.translatesAutoresizingMaskIntoConstraints = false

      let topConstant = view.safeAreaLayoutGuide.layoutFrame.height - 100
         bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
         NSLayoutConstraint.activate([
             bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
             bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
             bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             bottomSheetViewTopConstraint,
         ])
     }
}
