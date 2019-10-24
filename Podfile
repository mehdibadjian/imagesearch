platform :ios, '9.0'

target 'ImageSearch' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SnapKit'

    post_install do |installer|
    installer.pods_project.targets.each do |target|
      if ['SnapKit'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.2'
        end
      end
    end
  end

end
