require 'Octokit'

class Github
  TOKEN_PATH = File.expand_path("~/.prreview")

  def initialize(pull_request_url)
    @url = pull_request_url
  end

  private

  def token
    @token ||= begin
      if File.exist?(TOKEN_PATH)
        File.read(TOKEN_PATH)
      else
        token = Vim.evaluate("input('Create a GitHub authorization token and paste hit here: ')")
        File.open(TOKEN_PATH, "w") do |file|
          file.write token
        end
        token
      end
    end
  end

end
