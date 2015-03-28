require 'test_helper'

class PrReviewTest < UnitTest

  describe 'pr review' do

    before do
      repos = ['thinkthroughmath/mathjs-rest','neovim/neovim','jnicklas/capybara']
      query = 'state:open type:pr'
      options = {'sort'=>'updated', 'order'=>'asc', 'direction'=>'asc'}

      VCR.use_cassette("pull_requests") do
        PrReview.print_pull_requests repos, query, options
      end
    end

    it 'gets a list of pull requests' do
      assert_equal 43, VIM::Buffer.output.count
    end

    it 'shows date' do
      assert VIM::Buffer.output.first.include? '2015-01-26 19:19:00'
    end

    it 'shows assignee' do
      assert VIM::Buffer.output[4].include? 'justinmk'
    end

    it 'shows title' do
      assert VIM::Buffer.output.first.include? 'Add :element option'
    end

    it 'shows repo name' do
      assert VIM::Buffer.output.first.include? 'capybara'
    end

  end
end
