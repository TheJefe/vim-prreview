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

  def self.print_pull_requests repos, query, options
    @current = new()
    $pulls = []
    repos.each do |r|
      q = "#{query} repo:#{r}"
      $pulls +=  Octokit.search_issues(q, options).items
    end
    $pulls = $pulls.sort_by { |k| k["updated_at"] }
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

  def browse
    line_number = Vim.evaluate("line('.')-1")
    url = $pulls[line_number].html_url
    Vim.command "call netrw#NetrwBrowseX(\"#{url}\",0)"
  end

  def pull_request
    line_number = Vim.evaluate("line('.')-1")
    pull = get_pull_from_issue $pulls[line_number]
    repo_url  =pull.html_url.split('/')[3] + "/" + pull.html_url.split('/')[4]

    Vim.command("silent tabe")
    Vim.command("normal ggdG")
    b = VIM::Buffer.current
    Vim.command "Gishow #{pull.number} #{repo_url}"
  end

  def merge
    line_number = Vim.evaluate("line('.')-1")
    pull = get_pull_from_issue $pulls[line_number]
    branch = pull.head.ref
    repo  = pull.html_url.split('/')[4]
    if in_repo_dir? repo
      Vim.command "execute '! '. g:pr_review_merge_command \'#{branch}\'"
    else
      puts "To merge this PR you need to be in a directory for #{repo}"
    end
  end

  def in_repo_dir? repo
    remotes = `git remote -v`
    remotes.include? repo
  end

  def get_pull_from_issue issue
    repo  = issue.html_url.split('/')[3] + '/' + issue.html_url.split('/')[4]
    number = issue.number
    Octokit.pull repo, number
  end
end
