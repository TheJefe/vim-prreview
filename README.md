# vim-prreview

This plugin allows you to review a list of github pull requests across the repositories and labels that you are interested in.

This plugin uses the Octokit gem, so you'll need to make sure you have that installed

    gem install octokit

## Configuration

set the repositories that you would like to see pull requests listed for by putting this in your `vimrc` file

    let g:pr_review_github_repos = ['thejefe/vim-prreview','rails/rails']

set up custom pull request filters. For options see https://developer.github.com/v3/search/#search-issues

    let g:pr_review_query = "state:open type:pr label:\"Needs QA\""
    let g:pr_review_options = {'sort': 'updated', 'order': 'asc'}

Add a custom mere commmand, defaults to `git pull --no-ff --no-edit`

    let g:pr_review_merge_command = 'git stash; git checkout rc; git reset --hard origin/rc; git pull; git pull --no-ff --no-edit origin'

For now, the github authentication credentials are coming from environment variables. You'll want to both of these set.

    export GITHUB_TOKEN=123
    export GITHUB_USERNAME=thejefe

## Further enhancement!

To get the best experience, you should also install the [the-jefe/github-issues.vim](https://github.com/TheJefe/github-issues.vim) plugin. Until my changes are merged into the original at [jaxbot/github-issues.vim](https://github.com/jaxbot/github-issues.vim), then you should be directed there.

## Mappings

in the PR list window I have

- `o` mapped to open a PR in a browser
- `q` to `:q` the split window
- `m` to merge the selected PR
- `<return>` to open the PR in a new tab

#### From a PR view

- `<return>` to open commit list of file change in a new tab
- `s` to open commit list of file change in a vertical split
- `q` to `:q` the window

## Demo
![vim-prreview](https://cloud.githubusercontent.com/assets/2390653/5782762/cf46ba20-9d8b-11e4-9cbd-0d4462249d60.gif)

### Commits using [the-jefe/github-issues.vim](https://github.com/TheJefe/github-issues.vim)

![commits](https://cloud.githubusercontent.com/assets/2390653/6881865/eef16b16-d546-11e4-8e4a-d0554f83b30e.gif)

### File Diff using [the-jefe/github-issues.vim](https://github.com/TheJefe/github-issues.vim)

![file_diff](https://cloud.githubusercontent.com/assets/2390653/6881891/d038ff80-d547-11e4-8027-0202756c2448.gif)

## Run tests

    rake test

or just

    rake
