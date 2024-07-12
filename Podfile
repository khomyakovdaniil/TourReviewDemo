platform :ios, '15.0'
use_frameworks!

target 'TourReviewDemo' do


  #UI
  pod 'StepSlider'
  pod 'TinyConstraints'

  #Network
  pod 'Moya'

  #Dependency injection
  pod 'Swinject'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
