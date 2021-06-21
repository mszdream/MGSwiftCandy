//
//  MG+Image+Extension.swift
//  MGSwiftCandy
//
//  Created by mszdream on 2021/5/6.
//  Copyright (c) 2021 mszdream. All rights reserved.
//

import Foundation

extension MGImage: MGWrapperEnable {}
public extension MGWrapper_Mg where MGOriginType: MGImage {
    /// Get the color in image
    /// - Parameters:
    ///   - image: Target image
    ///   - x: Pixel x coordinate
    ///   - y: Pixel y coordinate
    func color(x: CGFloat, y: CGFloat) -> MGColor? {
        self.color(x: Int(x), y: Int(y))
    }
    
    func color(x: Int, y: Int) -> MGColor? {
        guard x >= 0, x < Int(origin.size.width), y >= 0, y < Int(origin.size.height) else {
            return nil
        }
        
        let provider = origin.cgImage?.dataProvider
        let providerData = provider?.data
        let data = CFDataGetBytePtr(providerData)
        let numberOfComponents = 4
        let pixelData = ((Int(origin.size.width) * y) + x) * numberOfComponents
        
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData + 2]) / 255.0
        let a = CGFloat(data![pixelData + 3]) / 255.0
        
        return MGColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Blurred the image
    /// - Parameters
    ///   - blurRadius: Blurred radius(the bigger, The more blurred).
    /// - Returns:
    ///   - The blurred image
    func blurImage(blurRadius: CGFloat = 10) -> UIImage {
        guard let cgImage = origin.cgImage else {
            return origin
        }
        
        // Get the original picture
        let input = CIImage(cgImage: cgImage)
        // Using Gaussian Blur filter
        let filter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: input])
        // Set the blur radius value(the bigger, The more blurred).
        filter?.setValue(blurRadius, forKey: kCIInputRadiusKey)
        // Blurred image of ciimage type
        guard let output = filter?.outputImage else {
            return origin
        }
        
        // Creates a blurred image of cgimage type based on the specified region,
        // The starting position((0, 0)) is the lower left corner
        let rect = CGRect(origin: .zero, size: CGSize(width: origin.size.width, height: origin.size.height))
        let context = CIContext(options: nil)
        guard let cgOutPutImage = context.createCGImage(output, from: rect) else {
            return origin
        }
        
        return UIImage(cgImage: cgOutPutImage)
    }
    
    /// Get a copy of image with different sizes
    /// - Parameters:
    ///   - reSize:The size of the image copy
    ///   - scale: The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen. We can get it through UIScreen.main.scale
    /// - Returns:
    ///   - A new image of UIImage type
   func reSizeImage(reSize: CGSize, scale: CGFloat = 1.0) -> UIImage? {
       UIGraphicsBeginImageContextWithOptions(reSize, false , scale);
       origin.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
       let reSizeImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext ();
    
       return  reSizeImage;
    }
    
    /// Get a copy of image with different ratios
    /// - Parameters:
    ///   - scaleSize:The ratios of the image copy(such as: 0.5, 1.0, 2.0)
    ///   - scale: The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen. We can get it through UIScreen.main.scale
    /// - Returns:
    ///   - A new image of UIImage type
    func scaleImage(scaleSize: CGFloat, scale: CGFloat = 1.0)-> UIImage? {
       let reSize = CGSize(width: origin.size.width * scaleSize,  height: origin.size.height * scaleSize)
       return reSizeImage(reSize: reSize)
    }
    
    /// Convert image to Base64 string
    /// - Returns:
    ///   - base64 string
    var base64EncodedString: String? {
        let data = compressedData(quality: 1.0)
        return data?.base64EncodedString()
    }
    
    /// Compressed UIImage from original UIImage.
    /// - Parameter
    ///   - quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns:
    ///   - Optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }
    
    /// Compressed UIImage data from original UIImage.
    /// - Parameters:
    ///   - quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns:
    ///   - Optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return origin.jpegData(compressionQuality: quality)
    }
    
}

// MARK: - init
public extension MGWrapper_Mg where MGOriginType: MGImage {
    /// Create UIImage from color and size.
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    static func `init`(color: MGColor = .clear, size: CGSize = CGSize(width: 32, height: 32)) -> MGImage? {
        guard size.width > 0, size.height > 0 else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        
        guard let aCgImage = image.cgImage else {
            return nil
        }
        
        return MGImage(cgImage: aCgImage)
    }
    
    /// Create UIImage from the data of base64
    /// - Parameters:
    ///   - base64: data of the string of base64
    static func `init`(base64: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
}
