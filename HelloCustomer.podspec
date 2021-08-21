Pod::Spec.new do |s|
  s.name          = "HelloCustomer"
  s.version       = "0.0.1"
  s.summary       = "iOS SDK for Hello Customer"
  s.description   = "iOS SDK for Hello Customer, including example app"
  s.homepage      = "TODO"
  s.license       = "MIT"
  s.author        = "HelloCustomer"
  s.platform      = :ios, "12.0"
  s.swift_version = "5.4"
  s.source        = {
    :git => "https://github.com/hellocustomer/HC.iosSDK.git",
    :tag => "#{s.version}"
  }
  s.source_files        = "HelloWorldSDK/**/*.{h,m,swift}"
  s.public_header_files = "HelloWorldSDK/**/*.h"
end
