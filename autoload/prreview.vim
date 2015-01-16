ruby $: << File.expand_path(File.join(Vim.evaluate('g:PRREVIEW_INSTALL_PATH'), '..', 'lib'))
ruby require 'pr_review'

fun! prreview#ReviewPRs()
  setlocal winfixheight
  silent execute 'botright new __PR_list'
  setlocal buftype=nofile
  setlocal bufhidden=delete
  ruby PrReview.print_pull_requests Vim.evaluate('g:pr_review_github_repos'), Vim.evaluate('g:pr_review_filter')
  "remove an extra line at the bottom and move the cursor to the top
  execute 'normal! Gddgg'
  nnoremap <buffer> <silent> o :call prreview#OpenInBrowser()<CR>
  nnoremap <buffer> <silent> q :q<CR>
  nnoremap <buffer> <silent> gx :call prreview#OpenInBrowser()<CR>
  nnoremap <buffer> <silent> m :call prreview#MergePr()<CR>
endfun

fun! prreview#OpenInBrowser()
  ruby PrReview.current.browse
endfun

fun! prreview#MergePr()
  if !exists("g:pr_review_merge_command")
    let g:pr_review_merge_command = "git pull --no-ff --no-edit"
  endif
  ruby PrReview.current.merge
endfun
