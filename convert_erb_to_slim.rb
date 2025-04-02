require 'html2slim'
require 'fileutils'

# Đường dẫn đến thư mục views của ứng dụng
views_directory = 'app/views'

# Lặp qua tất cả các thư mục và tệp trong thư mục views
Dir.glob("#{views_directory}/**/*.erb").each do |erb_file|
  # Tạo tên tệp .slim tương ứng
  slim_file = erb_file.sub(/\.erb$/, '.slim')
  
  # Đảm bảo thư mục đích tồn tại
  FileUtils.mkdir_p(File.dirname(slim_file))
  
  # Chuyển đổi tệp .erb thành .slim và lưu vào tệp mới
  File.open(slim_file, 'w') do |f|
    f.write Html2Slim.convert(File.read(erb_file))
  end

  # Xóa tệp .erb sau khi chuyển đổi nếu cần
  # File.delete(erb_file)  # Uncomment để xóa tệp .erb sau khi chuyển đổi
end

puts "Conversion completed!"
