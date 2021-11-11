# frozen_string_literal: true

module Emasser
  class CLI < Thor
    package_name 'Emasser'

    if ARGV[0].to_s.include? 'get'
      require 'emasser/get'
      register(Emasser::Get, 'get', 'get [RESOURCE]', 'Gets a resource')
    elsif ARGV[0].to_s.include? 'post'
      require 'emasser/post'
      register(Emasser::Post, 'post', 'post [RESOURCE]', 'Post resources')
    elsif ARGV[0].to_s.include? 'put'
      require 'emasser/put'
      register(Emasser::Put, 'put', 'put [RESOURCE]', 'PUt resources')
    end

    def self.exit_on_failure?
      true
    end
  end
end
