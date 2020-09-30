//
//  WikiFace.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/7.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import ImageIO

struct WikiFace {
    
    enum WikiFaceError: Error {
        case couldNotDownloadImage
    }
    
    fileprivate func taskHandler(_ completion: @escaping (UIImage?, Bool?) -> ()) -> (Data?, URLResponse?, Error?) -> (){
        
        return { (data, response, error) -> () in
            guard let _ = data, error == nil else {
                return completion(nil, false)
            }
            
            let emptyReturn = {
                 completion(nil, false)
            }

            let wikiDic = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any>
            print(wikiDic);
            
            guard let query = wikiDic["query"] as? Dictionary<String, Any> else {
                return emptyReturn()
            }
            guard let pages = query["pages"] as? Dictionary<String, Any> else {
                return emptyReturn()
            }
            guard let pageContent = pages.values.first as? Dictionary<String, Any> else {
                return emptyReturn()
            }
            guard let thumbnail = pageContent["thumbnail"] as? Dictionary<String, Any> else {
                return emptyReturn()
            }
            guard let thumbURL = thumbnail["source"] as? String else {
                return emptyReturn()
            }
            guard let url = URL(string: thumbURL), let faceImage = UIImage(data: try! Data(contentsOf: url)) else {
                return emptyReturn()
            }
            
            completion(faceImage, true)

        }
    }
    
    func url(from person: String, size: CGSize) -> URL?
    {
        let escapedPerson = person.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        let pixelsForAPIRequest = Int(max(size.width, size.height))
        let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedPerson!)&prop=pageimages&format=json&pithumbsize=\(pixelsForAPIRequest)")
        
        return url
    }
    
    func faceForPerson(_ person: String, size: CGSize, completion: @escaping (_ image: UIImage?, _ isFound: Bool?) -> ()) throws {
        
        let taskURL = url(from: person, size: size)
        
        guard let _ = taskURL else {
            throw WikiFaceError.couldNotDownloadImage
        }
        let task = URLSession.shared.dataTask(with: taskURL!, completionHandler: taskHandler(completion))
        task.resume()
        
    }
    
    static func centerImageViewOnFace(_ imageView: UIImageView) {
        let context = CIContext(options: nil)
        let options = [CIDetectorAccuracy : CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options)
        
        let faceImage = imageView.image
        let ciImage = CIImage(cgImage: faceImage!.cgImage!)
        
        let features = detector?.features(in: ciImage)
        
        guard let featuresCount = features?.count, featuresCount > 0 else {
            return
        }
        
        var face: CIFaceFeature!
        features?.forEach({ rect in
            face = rect as? CIFaceFeature
        })
        
        var faceRectWithExtendedBounds = face.bounds
        faceRectWithExtendedBounds.origin.x -= 20
        faceRectWithExtendedBounds.origin.y -= 30
        faceRectWithExtendedBounds.size.width += 40
        faceRectWithExtendedBounds.size.height += 60
        
        let x = faceRectWithExtendedBounds.origin.x / faceImage!.size.width
        let y = (faceImage!.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage!.size.height
        
        let widthFace = faceRectWithExtendedBounds.size.width / faceImage!.size.width
        let heightFace = faceRectWithExtendedBounds.size.height / faceImage!.size.height
        
        imageView.layer.contentsRect = CGRect(x: x, y: y, width: widthFace, height: heightFace)
    }
    
}
