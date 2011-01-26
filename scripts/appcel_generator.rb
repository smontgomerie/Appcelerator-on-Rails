#
# Superclass of all generators
#
class AppcelGenerator

  # Writes the file, and asks for confirmation before overwriting a file
  def write_file(file, content, overwrite = false)
    if (File.exists?(file) && overwrite == false)
      puts "#{file} exists.  Overwrite (y/N)?"
      if ( (input = STDIN.gets.downcase.chomp) != "y")
        puts input
        return
      end
    end

    puts "#{file}"

    f = File.open(file, "w+")
    f.write(content)
    f.close

  end

  def generate(args)
    raise NotImplementedError
  end
end