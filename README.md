# Explosion Pills RC Files for Unix

The `defect` script copies every file from `~` matching a
file in the repo to the repo.

The `infect` script intelligently copies every file from
the repo to `~`

* Automatically adds new files
* Asks to add directories
* Skips copying identical files
* Asks to copy/skip/diff existing unmatching files

All files copied to and from the repo have identical names
to their targets with two exceptions (because this is a
git repo):

* .explosion-pills-gitignore -> .gitignore (global .gitignore)
* .explosion-pills-gitconfig -> .gitconfig (global .gitconfig)

I have copies of all vim plugins I use. This may not be the
best idea, but it keeps them locked down and makes their
addition atomic. I'm sticking with Pathogen.
