Pod::Spec.new do |s|
    s.name             = 'UnifyID-HumanDetect'
    s.version          = '2.0.3'
    s.summary          = 'Passive detect whether your app is being used by a human or a bot.'
    s.homepage         = 'https://github.com/UnifyID/unifyid-ios-sdk/blob/master/HumanDetect.md'
    s.license          = { :type => 'Commercial', :text => 'See https://unify.id/terms' }
    s.author           = { 'UnifyID' => 'support@unify.id' }

    s.source = { :http => "https://github.com/UnifyID/github-ios-sdk/releases/download/v2.0.24/UnifyID-HumanDetect-2.0.3.zip" }
    s.vendored_frameworks = "HumanDetect.framework"

    s.swift_version = '4.2'
    s.platform = :ios, '10.0'

    s.dependency 'UnifyID-Core', '~> 2.0.24'
    s.dependency 'SwiftProtobuf', '~> 1.8.0'
  end
