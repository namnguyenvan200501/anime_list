//
//  ImageLoader.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import Foundation
import UIKit

class ImageLoader {
    private let cache: NSCache<NSURL, UIImage> = NSCache()

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            guard let image = UIImage(data: data) else { return }

            self.cache.setObject(image, forKey: url as NSURL)

            completion(image)
        }

        task.resume()
    }
}
