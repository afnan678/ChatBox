//
//  GetImage.swift
//  AALATask
//
//  Created by Afnan Ahmed on 20/12/2023.
//

import Foundation
import UIKit
import Kingfisher

class GetImage {
    public static func getImage(url: URL, image: UIImageView){
        
        image.kf.indicatorType = .activity
        image.kf.setImage(
            with: url,
            placeholder: UIImage(named: "noImage"),
            options: [
                //.forceRefresh,
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
            ]
        )
    }
    public static func getImage(url: URL) -> UIImage? {
        var downloadedImage: UIImage?
        let group = DispatchGroup()
        group.enter()

        let imageView = UIImageView()

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "noImage"),
            options: [
                //.forceRefresh,
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
            ]
        ) { result in
            switch result {
            case .success(let value):
                downloadedImage = value.image
            case .failure(_):
                downloadedImage = nil
            }
            group.leave()
        }
        group.wait() // Wait for the asynchronous operation to complete

        return downloadedImage
    }
}
