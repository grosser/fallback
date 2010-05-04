module Fallback
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def fallback(*args)
      options = args.extract_options!

      methods =  if args.empty?
        options.except(:if, :unless, :to)
      else
        args
      end

      methods.each do |method, delegate_method|
        define_fallback(method, delegate_method, options)
      end
    end

    def define_fallback(method, delegate_method, options)
      delegate_method ||= method
      define_attribute_methods if respond_to?(:define_attribute_methods) # build attribute methods for AR

      define_method "#{method}_with_delegate" do
        current = send("#{method}_without_delegate")
        do_delegate = current.to_s.strip.empty?
        do_delegate ? send(options[:to]).send(delegate_method) : current
      end
      alias_method_chain method, :delegate
    end
  end
end