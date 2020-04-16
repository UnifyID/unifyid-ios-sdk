Pod::Spec.new do |s|
    s.name             = 'UnifyID'
    s.version          = '2.0.23'
    s.summary          = 'UnifyID Authentication SDK'

    s.description      = 'Authenticate and identify your users using motion data.'

    s.homepage         = 'https://github.com/UnifyID/unifyid-ios-sdk'
    s.license          = { :type => 'Commercial', :text => 'See https://unify.id/terms' }
    s.author           = { 'UnifyID' => 'support@unify.id' }

    s.platform = :ios, '10.0'
    s.swift_version = '4.2'
    s.source = { :http => "https://github.com/UnifyID/unifyid-ios-sdk/releases/download/v2.0.23/UnifyID-2.0.23.zip" }

    s.subspec 'HumanDetect' do |ss|
        s.dependency 'UnifyID-HumanDetect', '~> 2.0.2'
    end
  end
