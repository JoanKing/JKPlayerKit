
Pod::Spec.new do |spec|

  spec.name         = "JKPlayerKit"
  spec.version      = "0.0.6"
  spec.summary      = "简单的播放器"
  spec.description  = "这仅仅是一个播放器的雏形，支持边播边下载"

  spec.homepage     = "https://github.com/JoanKing/JKPlayerKit"
  spec.license      = "MIT"
  spec.author             = { "JoanKingWC" => "JoanKingWC@163.com" }
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/JoanKing/JKPlayerKit.git", :tag => "#{spec.version}" }
  # spec.source_files  = "Headers", "Headers/**/*"

  spec.vendored_frameworks = "Class/JKPlayerKitFramework.framework"

  spec.frameworks = ["UIKit", "Foundation","AVFoundation"]


  spec.requires_arc = true


end
