ruby $: << File.expand_path(File.join(Vim.evaluate('g:PRREVIEW_INSTALL_PATH'), '..', 'lib'))
ruby require 'pr_review'

fun! prreview#ReviewPRs()
  let vheight=10
  setlocal winfixheight
  silent execute 'botright '.vheight.' new __PR_list'
  setlocal buftype=nofile
  setlocal bufhidden=delete
  ruby PrReview.print_pull_requests Vim.evaluate('g:pr_review_github_repos')
  "remove an extra line at the bottom and move the cursor to the top
  execute 'normal! Gddgg'
  nnoremap <buffer> <silent> o :call prreview#OpenInBrowser()<CR>
  nnoremap <buffer> <silent> gx :call prreview#OpenInBrowser()<CR>
endfun

fun! prreview#OpenInBrowser()
  ruby PrReview.current.browse Vim.evaluate("line('.')-1")
  q
endfun
