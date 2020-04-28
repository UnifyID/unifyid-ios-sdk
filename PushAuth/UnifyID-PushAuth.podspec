Pod::Spec.new do |s|
    s.name             = 'UnifyID-PushAuth'
    s.version          = '2.0.11'
    s.summary          = 'Secure Push Authentication for Website Entry, UnifyID SDK'

    s.description      = <<-DESC
    Combined with UnifyID Web SDK, this provides a secure and quick way to implement second factor push authentication
    into your iOS mobile app.
    DESC

    s.homepage         = 'https://unify.id'
    s.license          = { :type => 'Commercial', :text => 'See https://unify.id/terms' }
    s.author           = { 'UnifyID' => 'support@unify.id' }

    s.source = { :http => "https://github.com/UnifyID/github-ios-sdk/releases/download/v2.0.24/UnifyID-PushAuth-2.0.11.zip" }
    s.vendored_frameworks = "PushAuth.framework"

    s.swift_version = '4.2'
    s.platform = :ios, '10.0'

    s.dependency 'UnifyID-Core', '~> 2.0.24'
    s.dependency 'SwiftProtobuf', '~> 1.8.0'
  end
