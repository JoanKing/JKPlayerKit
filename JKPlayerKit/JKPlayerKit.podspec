
Pod::Spec.new do |spec|

  spec.name         = "JKPlayerKit"
  spec.version      = "0.0.5"
  spec.summary      = "简单的播放器"
  spec.description  = "这仅仅是一个播放器的雏形，支持边播边下载"

  spec.homepage     = "https://github.com/JoanKing/JKPlayerKit"
  spec.license      = "MIT"
  spec.author             = { "JoanKingWC" => "JoanKingWC@163.com" }
  spec.ios.deployment_target = "5.0"
  spec.source       = { :git => "https://github.com/JoanKing/JKPlayerKit.git", :tag => "#{spec.version}" }
  # spec.source_files  = "Class", "Class/**/*"
  spec.framework = "Class/JKPlayerKitFramework.framework"

  spec.requires_arc = true


end
