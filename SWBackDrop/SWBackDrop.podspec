
Pod::Spec.new do |spec|

  spec.name         = "SWBackDrop"
  spec.version      = "1.0.1"
  spec.summary      = "A Simple and Sweety BackDrop for iOS"

  spec.homepage     = "https://github.com/hoootan/SWBackDrop"

  spec.license      = "MIT"

  spec.author             = { "Hootan" => "hoootaan@gmail.com" }
  spec.social_media_url   = "https://twitter.com/hoootaan"

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/hoootan/SWBackDrop.git", :tag => "1.0.1" }
  spec.source_files  = "SWBackDrop/**/*"
  spec.swift_versions = [4.2]
  spec.exclude_files = "SWBackDrop/**/*.plist"

end
