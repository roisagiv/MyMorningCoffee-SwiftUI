source 'https://cdn.cocoapods.org/'
source "https://github.com/liamnichols/pointfreeco-specs.git"


# Uncomment the next line to define a global platform for your project
platform :ios, "16.4"

pod "SwiftLint"
pod "SwiftFormat/CLI"

target "MyMorningCoffee" do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyMorningCoffee
  pod "Alamofire"

  begin
    script_phase :name => "SwiftFormat",
                 :execution_position => :before_compile,
                 :script => 'if [[ "Debug" == "${CONFIGURATION}" && ! $ENABLE_PREVIEWS == "YES" ]]; then "${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat" --swiftversion ${SWIFT_VERSION} --config ".swiftformat" "${SRCROOT}" ; fi'

    script_phase :name => "SwiftLintAutocorrect",
      :execution_position => :before_compile,
      :script => 'if [[ "Debug" == "${CONFIGURATION}" && ! $ENABLE_PREVIEWS == "YES" ]]; then "${PODS_ROOT}/SwiftLint/swiftlint" --fix --config ".swiftlint.yml" "${SRCROOT}" ; fi'

    script_phase :name => "SwiftLint",
      :execution_position => :after_compile,
      :script => 'if [ "Debug" == "${CONFIGURATION}" && ! $ENABLE_PREVIEWS == "YES" ]; then "${PODS_ROOT}/SwiftLint/swiftlint" --config ".swiftlint.yml" "${SRCROOT}" ; fi'
  end

  target "MyMorningCoffeeTests" do
    inherit! :search_paths
    # Pods for testing
    pod "OHHTTPStubs/Swift"
    pod "SnapshotTesting"
  end

  target "MyMorningCoffeeUITests" do
    # Pods for testing
  end

  # Fix Xcode 14 warnings "Run script build phase '[CP] _____' will be run during every build because it does not specify any outputs."
  # Based on https://github.com/CocoaPods/CocoaPods/issues/11444#issuecomment-1300023416
  post_integrate do |installer|
    main_project = installer.aggregate_targets[0].user_project
    main_project.targets.each do |target|
      target.build_phases.each do |phase|
        next unless phase.is_a?(Xcodeproj::Project::Object::PBXShellScriptBuildPhase)
        next unless phase.name.start_with?("[CP")
        next unless (phase.input_paths || []).empty? && (phase.output_paths || []).empty?
        phase.always_out_of_date = "1"
      end
    end
    main_project.save
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "16.4"
      end
    end
  end
end
