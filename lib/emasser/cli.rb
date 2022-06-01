# frozen_string_literal: true

module Emasser
  class CLI < Thor
    package_name 'Emasser'

    if ARGV[0].to_s.include? 'get'
      require 'emasser/get'
      register(Emasser::Get, 'get', 'get [RESOURCE]', 'Gets a resource')
    elsif ARGV[0].to_s.include? 'post'
      require 'emasser/post'
      register(Emasser::Post, 'post', 'post [RESOURCE]', 'Posts resources')
    elsif ARGV[0].to_s.include? 'put'
      require 'emasser/put'
      register(Emasser::Put, 'put', 'put [RESOURCE]', 'Puts resources')
    elsif ARGV[0].to_s.include? 'del'
      require 'emasser/delete'
      register(Emasser::Delete, 'delete', 'delete [RESOURCE]', 'Deletes resources')
    elsif (ARGV[0].to_s.include? '-v') || (ARGV[0].to_s.include? '-V')
      puts "emasser version: #{Emasser::VERSION}".green
      exit
    elsif ARGV[0].to_s.include? 'hello'
      user_name = ENV.fetch('USERNAME', 'rookie')
      puts "Hello #{user_name} - enjoy using emasser version #{Emasser::VERSION}!".cyan
      exit
    end

    def help
      puts 'Emasser commands:'.yellow
      puts '  emasser [get, put, post, delete, -v, or -V]'.yellow
    end

    def self.exit_on_failure?
      true
    end
  end
end
