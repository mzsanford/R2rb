
require 'r2'

describe R2 do
  before(:each) do
    @r2 = R2::Swapper.new
  end

  context ".r2 static call" do
    it "processes CSS" do
      R2.r2("/* comment */\nbody { direction: rtl; }\nimg { padding: 4px;}").should == "body{direction:ltr;}img{padding:4px;}"
    end
  end

  context "declartion_swap" do
    it "should handle nil" do
      @r2.declartion_swap(nil).should == ''
    end

    it "should handle invalid declarations" do
      @r2.declartion_swap("not a decl").should == ''
    end

    it "should swap a swappable parameter" do
      @r2.declartion_swap("padding-right:4px").should == 'padding-left:4px;'
    end

    it "should swap a swappable quad parameter" do
      @r2.declartion_swap("padding:1px 2px 3px 4px").should == 'padding:1px 4px 3px 2px;'
    end

    it "should ignore other parameters" do
      @r2.declartion_swap("foo:bar").should == 'foo:bar;'
    end
  end

  context "minimize" do
    it "should handle nil" do
      @r2.minimize(nil).should == ""
    end

    it "should strip comments" do
      @r2.minimize("/* comment */foo").should == "foo"
    end

    it "should remove newlines" do
      @r2.minimize("foo\nbar").should == "foobar"
    end

    it "should remove carriage returns" do
      @r2.minimize("foo\rbar").should == "foobar"
    end

    it "should collapse multiple spaces into one" do
      @r2.minimize("foo       bar").should == "foo bar"
    end
  end

  context "direction_swap" do
    it "should swap 'rtl' to 'ltr'" do
      @r2.direction_swap('rtl').should == 'ltr'
    end

    it "should swap 'ltr' to 'rtl'" do
      @r2.direction_swap('ltr').should == 'rtl'
    end

    it "should ignore values other than 'ltr' and 'rtl'" do
      [nil, '', 'foo'].each do |val|
        @r2.direction_swap(val).should == val
      end
    end
  end

  context "side_swap" do
    it "should swap 'right' to 'left'" do
      @r2.side_swap('right').should == 'left'
    end

    it "should swap 'left' to 'right'" do
      @r2.side_swap('left').should == 'right'
    end

    it "should ignore values other than 'left' and 'right'" do
      [nil, '', 'foo'].each do |val|
        @r2.side_swap(val).should == val
      end
    end
  end

  context "quad_swap" do
    it "should swap a valid quad value" do
      @r2.quad_swap("1px 2px 3px 4px").should == "1px 4px 3px 2px"
    end

    it "should skip a pair value" do
      @r2.quad_swap("1px 2px").should == "1px 2px"
    end
  end

  context "border_radius_swap" do
    it "should swap a valid quad value" do
      @r2.border_radius_swap("1px 2px 3px 4px").should == "2px 1px 4px 3px"
    end

    it "should skip a triple value" do
      @r2.border_radius_swap("1px 2px 3px").should == "2px 1px 2px 3px"
    end

    it "should skip a pair value" do
      @r2.border_radius_swap("1px 2px").should == "2px 1px"
    end
  end
end