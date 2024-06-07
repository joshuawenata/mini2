import Foundation
import CoreText

func registerFonts() {
    let fontNames = ["Roboto-Regular", "Roboto-Bold", "Roboto-Light", "Roboto-Medium", "Roboto-Thin"]
    for fontName in fontNames {
        let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
}

