//
//  File.swift
//  
//
//  Created by Joe Blau on 9/26/20.
//

import Plot
import Publish

public enum PublishError: Error {
    case castSiteError
    case notImplemented
}

extension Theme where Site: BlauThemable {
    static var blau: Self {
        Theme(htmlFactory: DeployHTMLFactory(),
              resourcePaths: [
                "Resources/BlauTheme/css/styles.css"
              ])
    }
    
    struct DeployHTMLFactory: HTMLFactory {
        func makeIndexHTML(for index: Index,
                           context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: index, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(
                        .contentBody(index.content.body),
                        .p(.text("~$ "),
                           .span(.class("blink"), .text("█"))
                        )
                    )
                )
            )
        }
        
        func makeSectionHTML(for _: Section<Site>,
                             context _: PublishingContext<Site>) throws -> HTML {
            HTML()
        }
        
        func makeItemHTML(for _: Item<Site>,
                          context _: PublishingContext<Site>) throws -> HTML {
            HTML()
        }
        
        func makePageHTML(for page: Page,
                          context: PublishingContext<Site>) throws -> HTML {
            HTML(
                .lang(context.site.language),
                .head(for: page, on: context.site),
                .body(
                    .header(for: context, selectedSection: nil),
                    .wrapper(.contentBody(page.body)),
                    .footer(for: context.site)
                )
            )
        }
        
        func makeTagListHTML(for _: TagListPage,
                             context _: PublishingContext<Site>) throws -> HTML? {
            HTML()
        }
        
        func makeTagDetailsHTML(for _: TagDetailsPage,
                                context _: PublishingContext<Site>) throws -> HTML? {
            HTML()
        }
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        return .header(
            .wrapper(
                .h1(.text(context.site.name)),
                .h4(.text("I help teams ship functional iOS prototypes in 2-4 weeks."))
            )
        )
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }
    
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer()
    }
}
