module R2
  module FunctionFlipper
    def self.flip(val)
      function, args = self.parse_function(val)
      if function
        swapped_args = self.swap_args(function, args)
        # Magic here.
        return "#{function}(#{swapped_args.join(',')})"
      end

      return val
    end

  private

    CSS_FUNCTION_PROCS = {
      'gradient' => lambda {|val| self.lr_swap(val) },
      'linear-gradient' => lambda {|val| self.lr_swap(val) },
    }

    def self.parse_function(str)
      if str =~ /\A([a-z-]+)\((.*)\)\s*\z/
        return [$1, $2.split(/,/)]
      end
    end

    def self.swap_args(function, args)
      canonical_func = function.sub(/^(-moz-|-webkit-|-o-)/, '')

      if CSS_FUNCTION_PROCS[canonical_func]
        return CSS_FUNCTION_PROCS[canonical_func].call(args)
      end

      return args
    end

    def self.lr_swap(args)
      return args.map do |arg|
          arg.gsub(/(left|right)/) {|match| match == 'left' ? 'right' : 'left' }
        end
    end

  end
end
