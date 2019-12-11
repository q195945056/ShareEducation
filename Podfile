# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

target 'ShareEducation' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ShareEducation
  
  pod 'SnapKit'#Autolayout
  pod 'Kingfisher'#加载网络图片
  pod 'SwiftyJSON'#json串解析
  pod 'BetterSegmentedControl'#SegmentedControl
  pod 'Jelly'
  pod 'TYCyclePagerView'
  pod 'Then'
  pod 'Moya-ObjectMapper'
  pod 'SwiftDate'
  pod 'IQKeyboardManagerSwift'
  pod 'MJRefresh'
  pod 'Cache'
  pod 'SwiftyJSON'
  pod 'PKHUD'
  pod 'RSKPlaceholderTextView'
  pod 'R.swift'
  
end

post_install do |pi|
  # https://github.com/CocoaPods/CocoaPods/issues/7314
  fix_deployment_target(pi)
end

def fix_deployment_target(pod_installer)
  if !pod_installer
    return
  end
  puts "Make the pods deployment target version the same as our target"
  
  project = pod_installer.pods_project
  deploymentMap = {}
  project.build_configurations.each do |config|
    deploymentMap[config.name] = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
  end
  # p deploymentMap
  
  project.targets.each do |t|
    puts "  #{t.name}"
    t.build_configurations.each do |config|
      oldTarget = config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']
      newTarget = deploymentMap[config.name]
      if oldTarget.to_f >= newTarget.to_f
        next
      end
      puts "    #{config.name} deployment target: #{oldTarget} => #{newTarget}"
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = newTarget
    end
  end
end
