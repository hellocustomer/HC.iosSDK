Pod::Spec.new do |s|
  s.name          = "HelloCustomer"
  s.version       = "1.0.0"
  s.summary       = "iOS SDK for Hello Customer"
  s.description   = "iOS SDK for Hello Customer, including example app"
  s.homepage      = "https://github.com/hellocustomer/HC.iosSDK"
  s.license       = "GNU General Public License v3.0"
  s.author        = "HelloCustomer"
  s.platform      = :ios, "12.0"
  s.swift_version = "5.4"
  s.resources = "HelloCustomer/*.xcassets"
  s.source        = {
    :git => "https://github.com/hellocustomer/HC.iosSDK.git",
    :tag => s.version.to_s
  }
  s.source_files        = "HelloCustomer/**/*.{swift,h}"
  s.public_header_files = "HelloCustomer/HelloCustomer.h"
end
