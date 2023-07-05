

Pod::Spec.new do |s|

  s.name             		= 'XYAlbum'
  s.version          		= '0.0.1'
  s.summary          		= 'a custom segment component view, it decouple、elegant and efficient.'
  s.description      		= <<-DESC
								   一个开箱即食的图片选择器,图片编辑器. 没有业务耦合,接口简洁
		                       DESC

  s.homepage         		= 'https://github.com/xiaoyouPrince/XYAlbum'
  s.license          		= { :type => 'MIT', :file => 'LICENSE' }
  s.author           		= { 'xiaoyouPrince' => 'xiaoyouPrince@163.com' }
  s.source           		= { :git => 'https://github.com/xiaoyouPrince/XYAlbum.git', :tag => s.version.to_s }

  s.ios.deployment_target 	= '9.0'
  s.swift_version = '5.0'
  s.requires_arc 			= true

  s.source_files 			= 'XYAlbum/**/*.{swift,h,m,xib}'
  s.resource_bundles     = {
    'XYAlbum' => ['XYAlbum/files/*.png']
  }

end
