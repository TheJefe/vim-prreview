require File.expand_path('../../lib/pr_review', __FILE__)
gem 'minitest'
gem 'vcr'

require 'vcr'
require 'pr_review'
require 'minitest/autorun'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

class UnitTest < MiniTest::Test
end

class VIM
  class Buffer
    $output

    def self.current
      new()
    end

    def initialize
      $output= []
    end

    def append garbage, string
      $output << string
    end

    def self.output
      $output
    end

  end
end
