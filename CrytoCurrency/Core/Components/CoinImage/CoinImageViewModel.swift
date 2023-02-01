//
//  CoinImageViewModel.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/01/11.
//

import Foundation
import Combine
import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoadingImage: Bool = false
    let coinModel: CryptoModel
    let imageService: CoinImageServiceRequest
    private let imageFolderName = "CoinImages"
    private var cancellables = Set<AnyCancellable>()
    // MARK: - init
    init(model: CryptoModel) {
        coinModel = model
        isLoadingImage = true
        imageService = CoinImageServiceRequest(urlString: coinModel.image)
        addImageSubscriber()
    }

    private func addImageSubscriber() {
        if let savedImage = LocalFileManager.fileManagerInstance.getImageFor(imageName: coinModel.id, folderName: imageFolderName) {
            image = savedImage
        } else {
            imageService
                .$coinImage
                .sink { [weak self] imageDownload in
                    self?.isLoadingImage = false
                    self?.image = imageDownload
                    if let _ = imageDownload {
                        LocalFileManager.fileManagerInstance.save(image: imageDownload!, imageName: (self?.coinModel.id)!, folderName: (self?.imageFolderName)!)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
