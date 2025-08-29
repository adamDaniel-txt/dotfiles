vim.cmd([[
	set makeprg=pandoc\ -f\ markdown\ --citeproc\ --bibliography\ ~/.local/share/index.bib\ --template\ eisvogel\ --highlight-style\ kate\ -o\ %:r.pdf\ %
]])
