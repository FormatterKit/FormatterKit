
def run(command, min_exit_status = 0)
  puts "Executing: `#{command}`"
  system(command)
  return $?.exitstatus
end

task :default => :spec

desc 'Run unit tests'
task :spec do
  status = ['English', 'French', 'Spanish', 'Russian'].map do |lang|
    puts "===\n=== Running tests for #{lang}\n==="
    run "xcodebuild -workspace FormatterKit.xcworkspace -scheme #{lang} -sdk iphonesimulator test | bundle exec xcpretty --test && exit ${PIPESTATUS[0]}"
  end.max.to_i

  exit status
end

