# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'mishanga.pro' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for mishanga.pro
  pod 'YandexMobileAds', '7.15.1'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end
