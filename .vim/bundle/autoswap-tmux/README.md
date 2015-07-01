# Vim Autoswap TMUX
Automatically swap your tmux window to a vim file if an
newer swap file already exists. If an older swap file exists,
it is deleted. If no matching session is found, open
read-only.

This is based on [this talk from Damian Conway](https://www.youtube.com/watch?v=aHm36-na4-4)
and derived from the `autoswap_mac` code that
can be [downloaded here](http://radar.oreilly.com/2013/10/more-instantly-better-vim.html)

This works by looking at all `tmux` panes and checking
their child processes to look for `vim <filename>`. As such,
this won't work if you open a file in a buffer and is
unlikely to work well for opening multiple files, files
with arguments etc.
