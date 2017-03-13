Pod::Spec.new do |s|
  s.name      = 'FormatterKit'
  s.version   = '1.8.2'
  s.license   = { :type => 'MIT' }
  s.summary   = '`stringWithFormat:` for the sophisticated hacker set.'
  s.homepage  = 'https://github.com/mattt/FormatterKit'
  s.social_media_url = 'https://twitter.com/mattt'
  s.author    = { 'Mattt Thompson' => 'm@mattt.me' }
  s.source    = { :git => 'https://github.com/mattt/FormatterKit.git',
                  :tag => s.version
                }

  s.description = "FormatterKit is a collection of well-crafted NSFormatter subclasses for things like units of information, distance, and relative time intervals. Each formatter abstracts away the complex business logic of their respective domain, so that you can focus on the more important aspects of your application."

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.requires_arc = true

  s.subspec 'Resources' do |ss|
    ss.resources = 'FormatterKit/FormatterKit.bundle'
    ss.source_files = 'FormatterKit/NSBundle+FormatterKit.{h,m}'
  end

  s.subspec 'AddressFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTAddressFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
    ss.osx.frameworks = 'AddressBook'
    ss.ios.frameworks = 'AddressBook', 'AddressBookUI'
  end

  s.subspec 'ArrayFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTArrayFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
  end

  s.subspec 'ColorFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTColorFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
  end

  s.subspec 'LocationFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTLocationFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
    ss.frameworks = 'CoreLocation'
  end

  s.subspec 'NameFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTNameFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
    ss.ios.frameworks = 'AddressBook'
  end

  s.subspec 'OrdinalNumberFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTOrdinalNumberFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
  end

  s.subspec 'TimeIntervalFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTTimeIntervalFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
  end

  s.subspec 'UnitOfInformationFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTUnitOfInformationFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
  end

  s.subspec 'URLRequestFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTURLRequestFormatter.{h,m}'
    ss.dependency 'FormatterKit/Resources'
  end
end
