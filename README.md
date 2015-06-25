## mGage test

Data can be imported with a rake task like

        rake import:votes VOTES=votes.txt


* Firstly this system is not perfect. It can be done with better isolation of variables, the best indexing for stored data changing erb to slim etc. It’s somewhat harder as I don’t have the full information about this data. For example how much data we have, how often it will be read, changed and so on.

* Secondly; the command line script – isn't enough precise definition. Import can be done with combination bash/php/perl etc with plain SQLes but I think you mean something else :) In my opinion a much more effective way to do it could be just a rake task.

* Third is a fairly standard task, nothing special. Maybe just a using "has_many through" connections between models Campaign and Candidate, will probably need more information about this set in future. And, btw: [Why You Don’t Need Has_and_belongs_to_many Relationships](http://blog.flatironschool.com/why-you-dont-need-has-and-belongs-to-many/)

* Decision about add votes counter to model candidate was taken 'cause I prefer fat models and slim controllers, but of 'course it's depend from situation, maybe if we take into account another part of our application we will need to use concerns or something else to reuse the same code to comply DRY rule. And, btw, if we will have much more data with votes – counting in this way isn't effective. Much more effective solution – use NoSQL database like Redis or just memcache to store our aggregated data and just use it for representation in view instead count every time "on the fly".

All other decisions about scope with uniqueness and similar – to have a consistent database in future.
