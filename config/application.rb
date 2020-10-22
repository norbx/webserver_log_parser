require 'rubygems'
require 'bundler/setup'
require 'csv'

Bundler.require

Dir['./lib/**/*.rb'].sort.each { |file| require file }
