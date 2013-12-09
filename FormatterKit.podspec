Pod::Spec.new do |s|
  s.name      = 'FormatterKit'
  s.version   = '1.3.2'
  s.license   = { :type => 'MIT' }
  s.summary   = '`stringWithFormat:` for the sophisticated hacker set.'
  s.homepage  = 'https://github.com/strava/FormatterKit'
  s.author    = { 'Mattt Thompson' => 'm@mattt.me' }
  s.source    = { :git => 'https://github.com/strava/FormatterKit.git', :tag => '1.3.2' }

  s.description = "FormatterKit is a collection of well-crafted NSFormatter subclasses for things like units of information, distance, and relative time intervals. Each formatter abstracts away the complex business logic of their respective domain, so that you can focus on the more important aspects of your application."

  s.requires_arc = true

  s.subspec 'AddressFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTAddressFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
    ss.frameworks = 'AddressBook'
  end

  s.subspec 'ArrayFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTArrayFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
  end

  s.subspec 'ColorFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTColorFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
  end

  s.subspec 'LocationFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTLocationFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
    ss.frameworks = 'CoreLocation'
  end

  s.subspec 'OrdinalNumberFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTOrdinalNumberFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
  end

  s.subspec 'TimeIntervalFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTTimeIntervalFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
  end

  s.subspec 'UnitOfInformationFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTUnitOfInformationFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
  end

  s.subspec 'URLRequestFormatter' do |ss|
    ss.source_files = 'FormatterKit/TTTURLRequestFormatter.{h,m}', 'FormatterKit/TTTLocalization.h'
    ss.resources = 'FormatterKitResources.bundle'
  end
end
