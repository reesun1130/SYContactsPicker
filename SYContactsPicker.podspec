Pod::Spec.new do |s|

s.name         = "SYContactsPicker"
s.version      = "1.0.2"
s.summary      = "SY Contacts Picker通讯录读取及展示，适配iOS9"
s.description  = <<-DESC
SY Contacts Picker contactsPicker通讯录读取及展示，适配iOS9
DESC

s.homepage     = "https://github.com/reesun1130/SYContactsPicker"

s.license      = { :type => 'MIT', :file => 'LICENSE_SY.txt' }
s.author       = { "reesun" => "ree.sun.cn@hotmail.com" }

s.source       = { :git => "https://github.com/reesun1130/SYContactsPicker.git", :tag => s.version }
s.source_files = "SYContactsPicker/*.{h,m}"
s.resources = "SYContactsPicker/*.{png,bundle}"

s.platform     = :ios, "8.0"
s.requires_arc = true

end
