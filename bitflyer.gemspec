
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitflyer/version'

Gem::Specification.new do |spec|
  spec.name          = 'bitflyer'
  spec.version       = Bitflyer::VERSION
  spec.authors       = ['Yuji Ueki']
  spec.email         = ['unhappychoice@gmail.com']