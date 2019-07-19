multi-file-line-differ
======================

Given a set of files, tell me which of the same lines are in each file.


 Woah!  This is nifty for sure.

"differ.sh" will "diff" n files with m lines and produce a tab delimited report
of what lines are in what files.  You can even add a -r to revers the match.

This is great for all sorts of things.  For example, I use it to find out what users
are in what `/etc/passwd` files on some systems. (Of course I must have all of the
`passwd` files in some folder first).  The -f parameter specifies a folder to look
for the files, where by default the "files" become the rows of the report and the
"lines" become the columns.

Perhaps an example is in order...

Lets say we have three files in a "data" folder that look like this:

system1.txt

    user1
    user3
    user5
    user7
    user9
    user11

system2.txt

    user2
    user4
    user6
    user8
    user10

system3.txt

    user1
    user2
    user3
    user8
    user9
    user10
    user11
    user12

Well.. lets get the "intersection" report for this..

    ./differ.sh -f ./data

                    user1     user10    user11    user12    user2     user3     user4     user5     user6     user7     user8     user9
    system1.txt         X                   X                             X                   X                   X                   X
    system2.txt                   X                             X                   X                   X                   X
    system3.txt         X         X         X         X         X         X                                                 X         X

We see there that user1 is on both system1 and system3 but not on system2.

You can also specify -r to reverse the rows and columns:

    ./differ.sh -r -f ./data

                        system1.txt         system2.txt         system3.txt
    user1               X                                       X
    user10                                  X                   X
    user11              X                                       X
    user12                                                      X
    user2                                   X                   X
    user3               X                                       X
    user4                                   X
    user5               X
    user6                                   X
    user7               X
    user8                                   X                   X
    user9               X                                       X

Anyway, this can come in handy at times.  Enjoy, my friends.
