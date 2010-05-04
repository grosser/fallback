module Fallback
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip

  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def fallback(*args)
      options = args.pop if args.last.is_a?(Hash) # extract_options!

      methods = options.reject{|k,v| [:if, :unless, :to].include?(k) }.to_a
      methods += args

      methods.each do |method, delegate_method|
        define_fallback(method, delegate_method, options)
      end
    end

    def define_fallback(method, delegate_method, options)
      delegate_method ||= method
      # build attribute methods for AR or alias will not work
      define_attribute_methods if respond_to?(:define_attribute_methods)

      define_method "#{method}_with_fallback" do
        current = send("#{method}_without_fallback")

        conditions = options.select{|k,v| [:if, :unless].include?(k)}
        do_delegate = if conditions.empty?
          current.to_s.strip.empty? # present?
        else
          # {:if => :a, :unless => :a} --> [true, false].all? --> false
          conditions.map do |condition, value|
            result = !!(value.respond_to?(:call) ? value.call(self) : send(value))
            condition == :unless ? result : !result
          end.all?
        end

        if do_delegate
          delegate = (options[:to] ? send(options[:to]) : self )
          delegate.send(delegate_method)
        else
          current
        end
      end
      
      # alias_method_chain method, :fallback
      alias_method "#{method}_without_fallback", method
      alias_method method, "#{method}_with_fallback"
    end
  end
end