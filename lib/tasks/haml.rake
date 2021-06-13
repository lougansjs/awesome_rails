namespace :erb do
  namespace :to do
    task :haml do
      files = `find . -name *.html.erb`
      files.each_line do |file|
        file.strip!
        `html2haml #{file} | cat > #{file.gsub(/\.erb$/, '.haml')}`
        `rm #{file}`
      end
    end
  end
end