Pod::Spec.new do |s|
s.name = 'YYActionSheet'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'An sample sctionSheet for iOS.'
s.homepage = 'https://github.com/SummerTrees/YYActionSheet'
s.authors = { 'summer' => 'zou.yingying@foxmail.com' }
s.source = { :git => 'https://github.com/SummerTrees/YYActionSheet.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'YYActionSheet/*.{h,m}'
end