import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct JoeBlau: BlauThemable {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case logs
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://joeblau.com")!
    var name = "Joe Blau"
    var description = "Founder • Entrepenur • Engineer"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try JoeBlau().publish(withTheme: .blau)
