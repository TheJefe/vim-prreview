if !exists('g:PRREVIEW_INSTALL_PATH')
  let g:PRREVIEW_INSTALL_PATH = fnamemodify(expand("<sfile>"), ":p:h")
end

command! PR call prreview#ReviewPRs()
