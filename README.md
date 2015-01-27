# vim-prreview

This plugin allows you to review a list of github pull requests across the repositories and labels that you are interested in.

This plugin uses the Octokit gem, so you'll need to make sure you have that installed

    gem install octokit

## Configuration

set the repositories that you would like to see pull requests listed for by putting this in your `vimrc` file

    let g:pr_review_github_repos = ['jkoenig311/vim-prreview','rails/rails']

set up custom pull request filters. For options see https://developer.github.com/v3/issues/

    let g:pr_review_filter= {'state': 'open', 'labels': 'Needs QA', 'sort': 'updated', 'direction': 'asc'}

Add a custom mere commmand, defaults to `git pull --no-ff --no-edit`

    let g:pr_review_merge_command = 'git stash; git checkout rc; git reset --hard origin/rc; git pull; git pull --no-ff --no-edit origin'

For now, the github authentication credentials are coming from environment variables. You'll want to both of these set.

    export GITHUB_TOKEN=123
    export GITHUB_USERNAME=jkoenig311

## Mappings

in the PR list window I have

- `o` mapped to open a PR in a browser
- `q` to `:q` the split window
- `m` to merge the selected PR

## Demo
![vim-prreview](https://cloud.githubusercontent.com/assets/2390653/5782762/cf46ba20-9d8b-11e4-9cbd-0d4462249d60.gif)

## Run tests

    rake test

or just

    rake
