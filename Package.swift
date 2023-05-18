// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "vapor-telegram",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Telegram",
            targets: ["Telegram"]),
        .executable(
            name: "TelegramBotServer",
            targets: ["TelegramBotServer"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/rawillk/vapor-bots.git", from: "0.1.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.76.0")
    ],
    targets: [
        .target(name: "Telegram", dependencies: [
            .product(name: "Bots", package: "vapor-bots"),
            .product(name: "Vapor", package: "vapor")
        ]),
        .executableTarget(name: "TelegramBotServer", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            "Telegram"
        ])
    ]
)
