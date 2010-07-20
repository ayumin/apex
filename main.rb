$:<< "./lib"
require 'apex'
require 'yaml'
require 'kconv'

src = "path/to/sources"
dst = "path/to/distinations"

package_to_class = YAML.load_file("package.yml")
p package_to_class
class_to_package = {}
package_to_class.each do |package,class_names|
  class_names.each do |class_name|
    class_to_package[class_name] = package
  end
end
system "del log.txt"
succeed = []

Dir[src+"/*.cls"].each do |path|
  if path =~ /XMLDom.cls/ || path =~ /startHereController.cls/
    next
  end
  apex = Apex.load_file(path)
  if class_to_package[apex.class_name]
    package_name = "com.accenture.forcefactory." + class_to_package[apex.class_name]
  else
    package_name = "com.accenture.forcefactory.other"
  end
  outpath = dst + "\\"+File.basename(path).sub(/cls$/,'java')
  #apex.methods.each do |m|
  #  puts "#{apex.class_name}::#{m.signeture}"
  #end
  File.open(outpath,"w") do |file|
    file.puts "package #{package_name};"
    file.puts "import java.lang.*;"
    file.puts "import java.util.*;"
    file.puts apex.to_java.tosjis
  end
  comp_result = %x{javac #{outpath} 2>>log.txt}
  result = %x{javadoc -d doc #{outpath} 2>>log.txt}
  
  if result =~ /エラー/
    puts "[ERROR] #{apex.class_name}"
  else
    succeed << outpath
  end
end

system "javadoc -d doc #{succeed.join(' ')}"
