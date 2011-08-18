Shortstack
==========
This is Code for America's knowledgebase about software, people, funders, and gov't entities.

Installation
------------
Clone the repo:
      git clone git@github.com:codeforamerica/shortstack.git
      cd shortstack

We recommend using Ruby Version Manager. Ruby 1.9.2 or later is required. If you have RVM installed:
      rvm gemset create shortstack
      rvm gemset use shortstack

Then:    
      bundle install

To Reset the DB & Data:

    bundle exec rake db:reset

After you've set up the database, launch the server:

    rails s


Setup Sunspot
-------------
We use Sunspot for search.

To start a development solr engine:
    $ rake sunspot:solr:start

To stop that:
    $ rake sunspot:solr:stop

You may have to build an index if you haven't already:
    $ rake sunspot:reindex

You should be good to go.  

Road Map
-------

**Feature Planning**
We use Pivotal Tracker for feature planning, bugs and general planning. our public url is at [https://www.pivotaltracker.com/projects/352877](https://www.pivotaltracker.com/projects/352877#)

**Releases**
Release information is available at [https://github.com/codeforamerica/shortstack/wiki/Releases](https://github.com/codeforamerica/shortstack/wiki/Releases)


Testing
-------

We use spork to speed up development tests.  Run the following in a separate console window. Note, you'll need to restart spork if you make changes to the environment as spork preloads it:

    spork

Until rake .9.2 is fixed, you'll most likely need to run: 

    bundle exec rspec your_test

or you can run autotest:

    autotest

Heroku: Staging, Development & Production
------------------------------------------

We use the recommended [Heroku setup for development & staging environments](http://devcenter.heroku.com/articles/multiple-environments)

Edit your git config file:

    vi .git/config

and copy/paste the following in:  

    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    [remote "origin"]
    url = git@github.com:codeforamerica/shortstack.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    [remote "heroku-master"]
    url = git@heroku.com:shortstack.git
    fetch = +refs/heads/*:refs/remotes/heroku/*
    [remote "heroku-staging"]
    url = git@heroku.com:shortstack-dev.git
    fetch = +refs/heads/*:refs/remotes/master/*
    branch = staging

To access heroku commands, you'll need to add --remote staging or --remote staging

### Branching & Tags

We use branching to delineate between staging and production.  

    git checkout origin staging
    git checkout origin master

We use tags to delineate releases. +.1 for major code releases. +.01 for design/css, small bug fixes or tests/seed data files.

    git tag 0.1

### Instructions for Staging (Development Environment):

Checkout the correct branch:

    git checkout origin staging

Merge your branch and push changes, if any, into staging (optional):  

    git checkout origin staging
    git merge branch_name
    git add .
    git commit -m 'Your message'
    git push heroku-staging staging:master

Check Code for America CI server to make sure the changes didn't break anything:

  http://ci.codeforamerica.org/ or dashboard in the office

Push the staging branch to Heroku:

    git push staging staging

Staging Url:

    http://shortstack-dev.codeforamerica.org

To migrate the database:

    heroku rake db:migrate --remote staging

### Instructions for Master (Production Environment):

Checkout the correct branch:

    git checkout origin master

Merge staging branch into master (optional):  

    git checkout origin master
    git merge staging
    git add .
    git commit -m 'Your message'

Add a tag for the release
    git tag 0.1
    git push origin master

Push the master branch to Heroku:

    git push master master

Update the Wiki with the Release Information:

[https://github.com/codeforamerica/shortstack/wiki/Releases](https://github.com/codeforamerica/shortstack/wiki/Releases)

Production Url:

    http://shortstack.codeforamerica.org

To migrate the database:

    heroku rake db:migrate --remote master

Credits
-------

Part of this app was developed using [Citizenry](https://github.com/reidab/citizenry), a local techie network developed for Portland.

Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](http://github.com/codeforamerica/shortstack/issues)
* by reviewing patches

Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/codeforamerica/shortstack/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

Copyright
---------
Copyright (c) 2011 Code for America Laboratories
See [LICENSE](https://github.com/codeforamerica/shortstack/blob/master/LICENSE.mkd) for details.


[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/shortstack.png)](http://stats.codeforamerica.org/projects/shortstack)