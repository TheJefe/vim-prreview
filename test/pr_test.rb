#gem 'minitest'
#gem 'vcr'
#$: << 'lib'
#require 'pr_review'
#require 'minitest/autorun'
## This stuff could be moved to a test_helper class, but for now, that is more then we need

require 'test_helper'

class PrReviewTest < UnitTest

  describe 'pr review' do

    before do
      repos = ['thinkthroughmath/mathjs-rest','jnicklas/capybara','rspec/rspec-rails']
      filter = {'state'=>'open', 'sort'=>'updated', 'direction'=>'asc'}

      VCR.use_cassette("pull_requests") do
        PrReview.print_pull_requests repos, filter
      end
    end

    it 'gets a list of pull requests' do
      assert_equal 57, VIM::Buffer.output.count
    end

    it 'shows date' do
      assert VIM::Buffer.output.first.include? '2015-01-23 20:58:38'
    end

    it 'shows assignee' do
      assert VIM::Buffer.output.last.include? 'ninjapanzer'
    end

    it 'shows title' do
      assert VIM::Buffer.output.first.include? 'If a view example\'s description contains no path elements, then do not attempt to load a helper based on the example description.'
    end

    it 'shows title' do
      assert VIM::Buffer.output.first.include? 'rspec-rails'
    end

  end
end
