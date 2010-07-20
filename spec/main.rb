require 'apex'
require 'yaml'
require 'kconv'

src = "D:/Documents and Settings/ayumu.aizawa/workspace/ReferenceInplementation/src/classes"
dst = "D:\\work\\apex\\tmp"
Dir[src+"/*.cls"].each do |path|
  apex = Apex.load(path)
  #puts File.basename(path) + "\t" + apex.class_name.to_s
  outpath = dst + "\\"+File.basename(path).sub(/cls$/,'java')
  #puts outpath
  File.open(outpath,"w") do |file|
    file.puts apex.to_java.tosjis
  end
end