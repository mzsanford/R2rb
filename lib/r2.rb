module R2

  def self.r2(css)
    ::R2::Swapper.new.r2(css)
  end

  class Swapper
    PROPERTY_MAP = {
      'margin-left' => 'margin-right',
      'margin-right' => 'margin-left',

      'padding-left' => 'padding-right',
      'padding-right' => 'padding-left',

      'border-left' => 'border-right',
      'border-right' => 'border-left',

      'border-left-width' => 'border-right-width',
      'border-right-width' => 'border-left-width',

      'border-radius-bottomleft' => 'border-radius-bottomright',
      'border-radius-bottomright' => 'border-radius-bottomleft',
      '-moz-border-radius-bottomright' => '-moz-border-radius-bottomleft',
      '-moz-border-radius-bottomleft' => '-moz-border-radius-bottomright',

      'left' => 'right',
      'right' => 'left'
    }

    VALUE_PROCS = {
      'padding'    => lambda {|obj,val| obj.quad_swap(val) },
      'margin'     => lambda {|obj,val| obj.quad_swap(val) },
      'text-align' => lambda {|obj,val| obj.side_swap(val) },
      'float'      => lambda {|obj,val| obj.side_swap(val) },
      'direction'  => lambda {|obj,val| obj.direction_swap(val) }
    }



    def r2(original_css)
      css = minimize(original_css)

      result = css.gsub(/([^\{]+\{[^\}]+\})+?/) do |rule|
        # break rule into selector|declaration parts
        parts = rule.match(/([^\{]+)\{([^\}]+)/)
        selector = parts[1]
        declarations = parts[2]

        rule_str = selector + '{'
        declarations.split(/;(?!base64)/).each do |decl|
          rule_str << declartion_swap(decl)
        end
        rule_str << "}"
        rule_str
      end

      return result
    end

    def minimize(css)
      return '' unless css

      css.gsub(/\/\*[\s\S]+?\*\//, '').   # comments
         gsub(/[\n\r]/, '').              # line breaks and carriage returns
         gsub(/\s*([:;,\{\}])\s*/, '\1'). # space between selectors, declarations, properties and values
         gsub(/\s+/, ' ')                 # replace multiple spaces with single spaces
    end

    def declartion_swap(decl)
      return '' unless decl

      matched = decl.match(/([^:]+):(.+)$/)
      return '' unless matched

      property = matched[1]
      value = matched[2]

      property = PROPERTY_MAP[property] if PROPERTY_MAP.has_key?(property)
      value = VALUE_PROCS[property].call(self, value) if VALUE_PROCS.has_key?(property)

      return property + ':' + value + ';'
    end

    def direction_swap(val)
      if val == "rtl"
        "ltr"
      elsif val == "ltr"
        "rtl"
      else
        val
      end
    end

    def side_swap(val)
      if val == "right"
        "left"
      elsif val == "left"
        "right"
      else
        val
      end
    end

    def quad_swap(val)
      # 1px 2px 3px 4px => 1px 4px 3px 2px
      points = val.to_s.split(/\s+/)

      if points && points.length == 4
        [points[0], points[3], points[2], points[1]].join(' ')
      else
        val
      end
    end
  end

end
