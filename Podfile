# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OMDBMovieAppMay2017' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', '~> 4.3'
  pod 'Kingfisher', '~> 3.3'
  pod 'MBProgressHUD', '~> 0.9'
  pod 'AGi18n', '~> 0.0'
  pod 'RealmSwift'
  pod 'KeychainSwift', '~> 8.0'
# Pods for OMDBMovieAppMay2017

  target 'OMDBMovieAppMay2017UITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OMDBMovieAppMay2017Tests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
