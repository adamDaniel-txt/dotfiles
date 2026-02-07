vim.cmd([[
	set makeprg=pandoc\ -f\ markdown\ --citeproc\ --bibliography\ ~/.local/share/index.bib\ --template\ eisvogel\ --listing\ -o\ %:r.pdf\ %
	" set makeprg=pandoc\ -f\ markdown\ --citeproc\ --bibliography\ ~/.local/share/index.bib\ --template\ eisvogel\ --top-level-division=\"chapter\"\ --highlight-style\ kate\ -o\ %:r.pdf\ %
]])
