Pod::Spec.new do |s|

  s.name         = "APLVideoPlayerView"
  s.version      = "0.1.0"
  s.summary      = "APLVideoPlayerView is a simple way to integrate a video player."

  s.description  = <<-DESC
        APLVideoPlayerView is a UIView that uses AV video player and enables easy use of
        a video player view in your iOS app. It can be used fullscreen or placed in a 
        container view. 
                   DESC

  s.homepage     = "https://github.com/apploft/APLVideoPlayerView.git"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Christine Pühringer" => "christine.puehringer@apploft.de" }

  s.platform     = :ios, "10.0"
  
  s.source       = { :git => "https://github.com/apploft/APLVideoPlayerView.git", :tag => s.version.to_s }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
