# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Mini-Tokopedia' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Mini-Tokopedia

pod 'Swinject'
pod 'SwinjectStoryboard'
pod 'RxSwift'
pod 'RxBlocking'
pod 'SegueManager'
pod 'Kingfisher'
pod 'Alamofire'
pod 'RxCocoa'
pod 'UIScrollView-InfiniteScroll'
pod 'RangeSeekSlider', :git => 'https://github.com/WorldDownTown/RangeSeekSlider.git', :branch => 'swift_4'

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

  target 'Mini-TokopediaTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
