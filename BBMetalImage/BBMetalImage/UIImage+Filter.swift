//
//  UIImage+Filter.swift
//  BBMetalImage
//
//  Created by Kaibo Lu on 4/2/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

import UIKit

public extension UIImage {
    public func bb_brightnessFiltered(withBrightness brightness: Float = 0) -> UIImage? {
        return filtered(with: BBMetalBrightnessFilter(brightness: brightness))
    }
    
    public func bb_exposureFiltered(withExposure exposure: Float = 0) -> UIImage? {
        return filtered(with: BBMetalExposureFilter(exposure: exposure))
    }
    
    public func bb_contrastFiltered(withContrast contrast: Float = 1) -> UIImage? {
        return filtered(with: BBMetalContrastFilter(contrast: contrast))
    }
    
    public func bb_saturationFiltered(withSaturaton saturation: Float = 1) -> UIImage? {
        return filtered(with: BBMetalSaturationFilter(saturation: saturation))
    }
    
    public func bb_gammaFiltered(withGamma gamma: Float = 1) -> UIImage? {
        return filtered(with: BBMetalGammaFilter(gamma: gamma))
    }
    
    public func bb_rgbFiltered(withRed red: Float = 1, green: Float = 1, blue: Float = 1) -> UIImage? {
        return filtered(with: BBMetalRGBFilter(red: red, green: green, blue: blue))
    }
    
    public func bb_hueFiltered(withHue hue: Float = 0) -> UIImage? {
        return filtered(with: BBMetalHueFilter(hue: hue))
    }
    
    public func bb_vibranceFiltered(withVibrance vibrance: Float = 0) -> UIImage? {
        return filtered(with: BBMetalVibranceFilter(vibrance: vibrance))
    }
    
    public func bb_whiteBalanceFiltered(withTemperature temperature: Float = 5000, tint: Float = 0) -> UIImage? {
        return filtered(with: BBMetalWhiteBalanceFilter(temperature: temperature, tint: tint))
    }
    
    public func bb_highlightShadowFiltered(withShadows shadows: Float = 0, highlihgts: Float = 1) -> UIImage? {
        return filtered(with: BBMetalHighlightShadowFilter(shadows: shadows, highlights: highlihgts))
    }
    
    public func bb_HighlightShadowTintFiltered(withShadowTintColor shadowTintColor: BBMetalColor = .red,
                                               shadowTintIntensity: Float = 0,
                                               highlightTintColor: BBMetalColor = .blue,
                                               highlightTintIntensity: Float = 0) -> UIImage? {
        
        return filtered(with: BBMetalHighlightShadowTintFilter(shadowTintColor: shadowTintColor,
                                                               shadowTintIntensity: shadowTintIntensity,
                                                               highlightTintColor: highlightTintColor,
                                                               highlightTintIntensity: highlightTintIntensity))
    }
    
    public func bb_lookupFiltered(withLookupTable lookupTable: MTLTexture, intensity: Float = 1) -> UIImage? {
        return filtered(with: BBMetalLookupFilter(lookupTable: lookupTable, intensity: intensity))
    }
    
    public func bb_colorInversionFiltered() -> UIImage? {
        return filtered(with: BBMetalColorInversionFilter())
    }
    
    public func bb_monochromeFiltered(withColor color: BBMetalColor = .red, intensity: Float = 0) -> UIImage? {
        return filtered(with: BBMetalMonochromeFilter(color: color, intensity: intensity))
    }
    
    public func bb_luminanceFiltered() -> UIImage? {
        return filtered(with: BBMetalLuminanceFilter())
    }
    
    private func filtered(with filter: BBMetalBaseFilter) -> UIImage? {
        let source = BBMetalStaticImageSource(image: self)
        filter.runSynchronously = true
        source.add(consumer: filter)
        source.transmitTexture()
        return filter.outputTexture?.bb_image
    }
}