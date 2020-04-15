Pod::Spec.new do |s|
    s.name             = 'UnifyID-Core'
    s.version          = '2.0.22'
    s.summary          = 'UnifyID Authentication SDK'

    s.description      = 'Authenticate and identify your users using motion data.'

    s.homepage         = 'https://unify.id'
    s.license          = { :type => 'Commercial', :text => 'See https://unify.id/terms' }
    s.author           = { 'UnifyID' => 'support@unify.id' }

    s.source = "https://github.com/UnifyID/unifyid-ios-sdk/releases/download/v2.0.22/UnifyID-Core-2.0.22.zip"
    s.platform = :ios, '10.0'
    s.swift_version = '4.2'
    s.vendored_frameworks = "UnifyID.framework"

    s.dependency 'Sodium', '~> 0.8.0'
  end
