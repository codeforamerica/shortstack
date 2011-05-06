Shortstack
==========
This is Code for America's knowledgebase about software, people, funders, cities and things we should know probably know something about.

Installation
------------
    $ bundle install
    $ rake db:seed

Setup Sunspot
-------------
We use Sunspot for search.

To start a development solr engine:
    $ rake sunspot:solr:start

To stop that:
    $ rake sunspot:solr:stop

You may have to build an index if you haven't already:
    $ rake sunspot:reindex

Documentation
-------------
We use the GitHub wiki for documentation.

Submitting an Issue
-------------------
We use the GitHub issue tracker to track bugs and features. Before submitting a bug report or feature request, check to make sure it hasn't already been submitted.
