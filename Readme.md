    class User < ActiveRecord::Base
      include Fallback
      has_one :shop

      # use shop.name if user.name is blank
      fallback :name => :name, :to => :shop

      # use shop.title if user.name is blank
      fallback :name => :title, :to => :shop

      # lambda.call ? user.name : shop.title
      #TODO fallback :title, :to => :shop, :if => lambda{|user| user.title.size > 3 }

      # user.overwrite_description? ? user.name : shop.title
      #TODO fallback :description, :to => :shop, :if => :overwrite_description?

    end


Install
=======
Rails plugin: ` script/plugin install git://github.com/grosser/fallback.git `

Author
======
[Michael Grosser](http://pragmatig.wordpress.com)  
grosser.michael@gmail.com  
Hereby placed under public domain, do what you want, just do not hold me accountable...
