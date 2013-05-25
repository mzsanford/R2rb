
require 'r2'

describe R2 do

  describe ".r2" do
    let(:r2)  { double("r2") }
    let(:css) { "body { direction: rtl; }" }

    it "provides a shortcut to .new#r2" do
      R2::Swapper.should_receive(:new).and_return(r2)
      r2.should_receive(:r2).with(css)
      R2.r2(css)
    end
  end

end

describe R2::Swapper do
  subject(:r2) { R2::Swapper.new }

  describe "#r2" do
    it "processes CSS" do
      r2.r2("/* comment */\nbody { direction: rtl; }\nimg { padding: 4px;}").should == "body{direction:ltr;}img{padding:4px;}"
    end

    it "handles media queries" do
      css = <<-EOS
        @media all and (max-width: 222px) {
          p {
            padding-left: 2px;
          }
        }
      EOS

      expected_result = "@media all and (max-width:222px){p{padding-right:2px;}}"

      flipped_css = r2.r2(css)

      flipped_css.should == expected_result
    end
  end

  describe "#declaration_swap" do
    it "should handle nil" do
      r2.declaration_swap(nil).should == ''
    end

    it "should handle invalid declarations" do
      r2.declaration_swap("not a decl").should == ''
    end

    it "should swap a swappable parameter" do
      r2.declaration_swap("padding-right:4px").should == 'padding-left:4px;'
    end

    it "should swap a swappable quad parameter" do
      r2.declaration_swap("padding:1px 2px 3px 4px").should == 'padding:1px 4px 3px 2px;'
    end

    it "should ignore other parameters" do
      r2.declaration_swap("foo:bar").should == 'foo:bar;'
    end
  end

  describe "#minimize" do
    it "should handle nil" do
      r2.minimize(nil).should == ""
    end

    it "should strip comments" do
      r2.minimize("/* comment */foo").should == "foo"
    end

    it "should remove newlines" do
      r2.minimize("foo\nbar").should == "foobar"
    end

    it "should remove carriage returns" do
      r2.minimize("foo\rbar").should == "foobar"
    end

    it "should collapse multiple spaces into one" do
      r2.minimize("foo       bar").should == "foo bar"
    end
  end

  describe "#direction_swap" do
    it "should swap 'rtl' to 'ltr'" do
      r2.direction_swap('rtl').should == 'ltr'
    end

    it "should swap 'ltr' to 'rtl'" do
      r2.direction_swap('ltr').should == 'rtl'
    end

    it "should ignore values other than 'ltr' and 'rtl'" do
      [nil, '', 'foo'].each do |val|
        r2.direction_swap(val).should == val
      end
    end
  end

  describe "#side_swap" do
    it "should swap 'right' to 'left'" do
      r2.side_swap('right').should == 'left'
    end

    it "should swap 'left' to 'right'" do
      r2.side_swap('left').should == 'right'
    end

    it "should ignore values other than 'left' and 'right'" do
      [nil, '', 'foo'].each do |val|
        r2.side_swap(val).should == val
      end
    end
  end

  describe "#quad_swap" do
    it "should swap a valid quad value" do
      r2.quad_swap("1px 2px 3px 4px").should == "1px 4px 3px 2px"
    end

    it "should skip a pair value" do
      r2.quad_swap("1px 2px").should == "1px 2px"
    end
  end

  describe "#shadow_swap" do
    it "should swap a 2 arg value" do
      r2.shadow_swap("1px 2px").should == "-1px 2px"
    end

    it "should swap a 2 arg value from rtl to ltr" do
      r2.shadow_swap("-1px 2px").should == "1px 2px"
    end

    it "should swap a 3 arg value" do
      r2.shadow_swap("1px 2px #000").should == "-1px 2px #000"
    end

    it "should swap a 4 arg value" do
      r2.shadow_swap("1px 2px 3px 4px").should == "-1px 2px 3px 4px"
    end

    it "should swap a 5 arg value" do
      r2.shadow_swap("1px 2px 3px 4px #000").should == "-1px 2px 3px 4px #000"
    end

    it "should swap a 6 arg value" do
      r2.shadow_swap("1px 2px 3px 4px #000 inset").should == "-1px 2px 3px 4px #000 inset"
    end

    it "should swap value starting with inset" do
      r2.shadow_swap("inset 1px 2px").should == "-1px 2px inset"
    end

  end

  describe "#border_radius_swap" do
    it "should swap a valid quad value" do
      r2.border_radius_swap("1px 2px 3px 4px").should == "2px 1px 4px 3px"
    end

    it "should skip a triple value" do
      r2.border_radius_swap("1px 2px 3px").should == "2px 1px 2px 3px"
    end

    it "should skip a pair value" do
      r2.border_radius_swap("1px 2px").should == "2px 1px"
    end
  end

  describe "#background_position_swap" do

    context "with a single value" do
      it "should ignore a named-vertical" do
        r2.background_position_swap('top').should == 'top'
      end

      it "should swap a named-horizontal 'left'" do
        r2.background_position_swap('left').should == 'right'
      end

      it "should swap a named-horizontal 'right'" do
        r2.background_position_swap('right').should == 'left'
      end

      it "should invert a percentage" do
        r2.background_position_swap('25%').should == '75%'
      end

      it "should convert a unit value" do
        r2.background_position_swap('25px').should == 'right 25px center'
      end
    end

    context "with a pair of values" do
      # Note that a pair of keywords can be reordered while a combination of
      # keyword and length or percentage cannot. So ‘center left’ is valid
      # while ‘50% left’ is not.
      # See: http://dev.w3.org/csswg/css3-background/#background-position

      it "should swap named-horizontal and ignore named-vertical" do
        r2.background_position_swap('right bottom').should == 'left bottom'
      end

      it "should swap named-horizontal and ignore unit-vertical" do
        r2.background_position_swap('left 100px').should == 'right 100px'
      end

      it "should convert unit-horizontal" do
        r2.background_position_swap('100px center').should == 'right 100px center'
      end

      it "should swap named-horizontal and ignore percentage-vertical" do
        r2.background_position_swap('left 0%').should == 'right 0%'
      end

      it "should invert first percentage-horizontal value in a pair" do
        r2.background_position_swap('25% 100%').should == '75% 100%'
      end
    end

    context "with a triplet of values" do
      it "should swap named-horizontal" do
        r2.background_position_swap('left 20px center').should == 'right 20px center'
      end
    end

    context "with a quad of values" do
      it "should swap named-horizontal value" do
        r2.background_position_swap('bottom 10px left 20px').should == 'bottom 10px right 20px'
      end
    end
  end

end
