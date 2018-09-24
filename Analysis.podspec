Pod::Spec.new do |s|
  s.name             = "Analysis"
  s.version          = "0.2.0"
  s.summary          = "Analyse your strings."

  s.description      = <<-DESC
Analysis analyses strings, checking word count, sentence count, frequency of words and more.
                       DESC

  s.homepage         = "https://github.com/BasThomas/Analysis"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Bas Broek" => "bas@basbroek.nl" }
  s.source           = { :git => "https://github.com/BasThomas/Analysis.git", :tag => s.version }
  s.social_media_url = "https://twitter.com/basthomas"

  s.ios.deployment_target = "8.0"
  s.swift_version         = "4.2"

  s.source_files = "Analysis/Classes/**/*"

  s.frameworks = "Foundation"
end
