Pod::Spec.new do |s|
  s.name = 'Alert'
  s.version = '0.0.1'
  s.summary = 'A short description of Alert.'
  s.description = <<-DESC
    A loooooooooooooooooong description of Alert.
  DESC
  s.homepage = 'http://dev.azure.com/aisberg-tech/CocoaPods/Alert'
  s.license = 'MIT'
  s.author = { 'OUrsus' => 'olegursus@gmail.com' }
  s.platform = :ios, '12.0'
  s.source = { git: 'http://dev.azure.com/Alert.git', tag: s.version.to_s }
  s.source_files = 'Sources/**/*.{swift}'
  s.resources = ['Resources/*']
  s.dependency 'Reusable'
  s.dependency 'RxFlow'
  s.dependency 'RxRelay'
end
