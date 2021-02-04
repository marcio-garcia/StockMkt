import ProjectDescription

// MARK: - Constants

let appName = "StockMkt"
let organizationName = "Oxltech"
let bundleIdPrefix = "com.oxltech"
let deploymentVersion = "11.0"

// MARK: - Build Settings

let customConfigurations: [CustomConfiguration] = [
    .release(name: "Release", xcconfig: "\(appName)/Resources/xcconfig/Prod.xcconfig"),
    .debug(name: "Dev", xcconfig: "\(appName)/Resources/xcconfig/Dev.xcconfig"),
    .debug(name: "Staging", xcconfig: "\(appName)/Resources/xcconfig/Staging.xcconfig")
]

let settingsDefinedInXcconfig: Set<String> = [
    "SWIFT_OBJC_BRIDGING_HEADER",
    "ENABLE_BITCODE",
    "EXCLUDED_ARCHS",
    "ONLY_ACTIVE_ARCH",
    "CODE_SIGN_IDENTITY",
    "CODE_SIGN_STYLE",
    "DEVELOPMENT_TEAM",
    "DEBUG_INFORMATION_FORMAT",
    "PRODUCT_BUNDLE_IDENTIFIER",
    "ASSETCATALOG_COMPILER_APPICON_NAME",
    "CODE_SIGN_ENTITLEMENTS"
]

let settings = Settings(configurations: customConfigurations, defaultSettings: DefaultSettings.recommended(excluding: settingsDefinedInXcconfig))

// MARK: - Deployment Target

let deploymentTarget = DeploymentTarget.iOS(targetVersion: deploymentVersion, devices: [.iphone, .ipad])

// MARK: - Build Schemes

let schemes: [Scheme] = [
    Scheme(name: appName,
           shared: true,
           buildAction: BuildAction(targets: [TargetReference(stringLiteral: appName)]),
           runAction: RunAction(configurationName: "Release"),
           archiveAction: ArchiveAction(configurationName: "Release"),
           profileAction: ProfileAction(configurationName: "Release"),
           analyzeAction: AnalyzeAction(configurationName: "Release")),
    Scheme(name: "\(appName)-Dev",
           shared: true,
           buildAction: BuildAction(targets: [TargetReference(stringLiteral: "\(appName)"), TargetReference(stringLiteral: "\(appName)Tests")]),
           testAction: TestAction(targets: [TestableTarget(stringLiteral: "\(appName)Tests")], configurationName: "Dev"),
           runAction: RunAction(configurationName: "Dev"),
           archiveAction: ArchiveAction(configurationName: "Dev"),
           profileAction: ProfileAction(configurationName: "Dev"),
           analyzeAction: AnalyzeAction(configurationName: "Dev")),
    Scheme(name: "\(appName)-Stg",
           shared: true,
           buildAction: BuildAction(targets: [TargetReference(stringLiteral: "\(appName)")]),
           runAction: RunAction(configurationName: "Staging"),
           archiveAction: ArchiveAction(configurationName: "Staging"),
           profileAction: ProfileAction(configurationName: "Staging"),
           analyzeAction: AnalyzeAction(configurationName: "Staging"))
]

// MARK: - Resources

let appResources: [FileElement] = [
//    .glob(pattern: "\(appName)/**/*.xib"),
    .glob(pattern: "\(appName)/**/*.storyboard"),

    .glob(pattern: "\(appName)/Resources/*.lproj/*"),
    .glob(pattern: "\(appName)/Resources/xcconfig/General.xcconfig"),
//    .glob(pattern: "\(appName)/Resources/Entitlements/**"),
//    .glob(pattern: "\(appName)/Resources/Font/**"),
//    .glob(pattern: "\(appName)/Resources/Firebase/**"),

    .folderReference(path: "\(appName)/Resources/Assets.xcassets"),
]

let testResources: [FileElement] = [
    //.glob(pattern: "\(appName)Tests/Resources/**/*.json"),
]

// MARK: - Dependencies

let appDependencies: [TargetDependency] = [
    .package(product: "Ivorywhite"),
    .package(product: "Charts")
]

let appPackages: [Package] = [
//    .package(url: "https://bitbucket.org/will-bank/will-ios-network.git", .upToNextMajor(from: Version(string: "0.1.2")!)),
    .package(url: "https://github.com/marcio-garcia/Ivorywhite.git", .branch("features/spm")),
    .package(url: "https://github.com/danielgindi/Charts.git", .branch("master"))
]

// MARK: - Additional Files

let additionalFiles: [FileElement] = [
//    .glob(pattern: "CHANGELOG.md"),
//    .glob(pattern: "\(appName)/ObjC_Bridge.h"),
//    .glob(pattern: "Scripts/**"),
]

// MARK: - Build Phases

let appRunScripts: [TargetAction] = [
//    .post(path: "Scripts/swiftlint.sh", name: "SwiftLint Script"),
//    .post(path: "Scripts/multi_sim.sh", name: "Simulators Script"),
//    .post(path: "Scripts/remove_unused_archs.sh", name: "Remove Unused Architectures Script"),
//    .post(path: "Scripts/crashlytics.sh", name: "Firebase Crashlytics")
]

// MARK: - Core Data Model

let appCoreDataModels: [CoreDataModel] = [
//    CoreDataModel(Path(stringLiteral: "\(appName)/Core/Data/WillDataModel.xcdatamodeld"), currentVersion: "WillDataModel")
]

// MARK: - Project

let project = Project(name: appName,
                      organizationName: organizationName,
                      packages: appPackages,
                      settings: settings,
                      targets: [
                        Target(name: appName,
                               platform: .iOS,
                               product: .app,
                               bundleId: "$(inherited)",
                               deploymentTarget: deploymentTarget,
                               infoPlist: .file(path: "\(appName)/Info.plist"),
                               sources: ["\(appName)/**/*.swift", "\(appName)/**/*.h"],
                               resources: appResources,
                               actions: appRunScripts,
                               dependencies: appDependencies,
                               coreDataModels: appCoreDataModels),
                        Target(name: "\(appName)Tests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "\(bundleIdPrefix).\(appName)Tests",
                               infoPlist: .file(path: "\(appName)Tests/Info.plist"),
                               sources: ["\(appName)Tests/**"],
                               resources: testResources,
                               dependencies: [.target(name: appName)]),
                      ],
                      schemes: schemes,
                      additionalFiles: additionalFiles)
