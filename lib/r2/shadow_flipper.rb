module R2
  module ShadowFlipper
    def self.flip(val)
      val = replace_commas_in_parentheses(val)
      val = val.split(/\s*,\s*/).map { |shadow| single_shadow_swap(shadow) }.join(', ')
      restore_commas(val)
    end

  private

    def self.replace_commas_in_parentheses(string)
      string.gsub(/\([^)]*\)/) { |parens| parens.gsub(',', '|||') }
    end

    def self.restore_commas(string)
      string.gsub('|||', ',')
    end

    def self.single_shadow_swap(val)
      args = val.to_s.split(/\s+/)

      #move 'inset' to the end
      args.push(args.shift) if args && args[0] == "inset"

      matched = args && args[0].match(/^([-+]?\d+)(\w*)$/)
      if matched
        return (["#{(-1 * matched[1].to_i)}#{matched[2]}"] + args[1..5]).compact.join(' ')
      else
        return val
      end
    end
  end
end
