require 'octokit'
require_relative 'github'

GITHUB_TOKEN=ENV['GITHUB_TOKEN']
GITHUB_USERNAME=ENV['GITHUB_USERNAME']

class PrReview

  def initialize()
    Octokit.configure do |c|
      c.login = GITHUB_USERNAME
      c.password = GITHUB_TOKEN
    end
  end

  def print_pull_requests
    options = { :state     => 'open',
                :labels    => 'Needs QA',
                :sort      => 'updated',
                :direction => 'asc'
    }
    pulls =  Octokit.issues('thinkthroughmath/apangea', options )
    print pulls
  end

  def print pulls
    b = VIM::Buffer.current
    pulls.each do |pull|
      date = pull.updated_at
      title = pull.title.strip
     b.append(0, "#{date}: #{title}")
    end
  end

  def commits
    pull = Octokit.pull 'thinkthroughmath/apangea', 1828
    commits = Octokit.pull_commits 'thinkthroughmath/apangea', 1828

    #branch_name = pull.head.ref
  end

end
