#!/usr/bin/ruby

require 'fileutils'

left_dir = "/tmp/ChangesForReview/Repository"
right_dir = "/tmp/ChangesForReview/Local"

# Copy file to temp directory
def copy_file(src, base, dest_dir)
  return if src == '/dev/null' or not File.exists?(src)
  dest = File.expand_path(base, dest_dir)
  puts "Added: #{base}"
  FileUtils.mkdir_p(File.dirname(dest))
  FileUtils.cp src, dest
end

# Parse out interesting arguments
base = ENV['BASE']
left, right = ARGV[0], ARGV[1]
copy_file(left, base, left_dir)
copy_file(right, base, right_dir)
