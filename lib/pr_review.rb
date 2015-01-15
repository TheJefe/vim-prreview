require 'octokit'
require_relative 'github'

GITHUB_TOKEN=ENV['GITHUB_TOKEN']
GITHUB_USERNAME=ENV['GITHUB_USERNAME']

class PrReview

  def self.current
    @current
  end

  def initialize()
    Octokit.configure do |c|
      c.login = GITHUB_USERNAME
      c.password = GITHUB_TOKEN
    end
  end

  def self.print_pull_requests repos, options
    @current = new()
    $pulls = []
    repos.each do |r|
      $pulls +=  Octokit.issues(r, options )
    end
    @current.print $pulls
  end

  def print pulls
    b = VIM::Buffer.current
    pulls.reverse_each do |pull|
      date  = pull.updated_at.strftime(format='%F %T')
      repo  = pull.html_url.split('/')[4]
      title = pull.title.strip
      assignee = pull.assignee ? pull.assignee.login : "unassigned"
     b.append(0, "#{date}: #{repo}: #{title} ~ #{assignee}")
    end
  end

  def commits
    pull = Octokit.pull 'thinkthroughmath/apangea', 1828
    commits = Octokit.pull_commits 'thinkthroughmath/apangea', 1828

    #branch_name = pull.head.ref
  end

  def browse line_number
    url = $pulls[line_number].html_url
    Vim.command "call netrw#NetrwBrowseX(\"#{url}\",0)"
  end
end
