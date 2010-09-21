Fallback when original is not present or somethings not right.  
For normal Object's and ActiveRecord's.

    class User < ActiveRecord::Base
      include Fallback

      # use description if detailed description is not available
      fallback :detailed_description => :description

      has_one :shop

      # use shop.name if user.name is blank
      fallback :name, :to => :shop

      # use shop.title if user.name is blank
      fallback :name => :title, :to => :shop

      # use shop.title if lambda is true (also works with :unless)
      fallback :title, :to => :shop, :if => lambda{|user| user.title.size < 10 }

      # use shop.title if user.title_to_short? is true
      fallback :title, :to => :shop, :if => :title_to_short?
    end

Install
=======
Gem `  sudo gem install fallback  `  
Or as Rails plugin: ` script/plugin install git://github.com/grosser/fallback.git `

Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...