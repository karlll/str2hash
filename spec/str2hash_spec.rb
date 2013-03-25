require 'rspec'
require 'str2hash'
require 'parslet/convenience'


describe HashParse do

=begin
it 'should parse Ruby values' do

  val_strs = ["123","'123'","\"foo\"","/foo/",":foo",":SYMBOL",":f_O_o","123.0","0x12AB","0b0101001001"]

  p = HashParse.new

  val_strs.each do |item|
    pp p.parse(item)
  end


end
=end

  it 'should parse a basic value hash' do
    p = HashParse.new

    prods = [
        {s: "{ :foo => 123 }", h: {:foo => 123}},
        {s: "{ :foo => :bar }", h: {:foo => :bar}},
        {s: "{ 123 => 456 }", h: {123 => 456}},
        {s: "{ foo: 456 }", h: {:foo => 456}},
        {s: "{ foo: :bar }", h: {:foo => :bar}},
        {s: "{ foo: '123' }", h: {:foo => '123'}},
        {s: "{ foo: \"123\" }", h: {:foo => "123"}},
        {s: "{ foo: /foo/ }", h: {:foo => /foo/}},
        {s: "{ foo: true }", h: {:foo => true}},
        {s: "{ :foo => :bar, :foo2 => :bar2}", h: {:foo => :bar, :foo2 => :bar2}},
        {s: ":foo => :bar, :foo2 => :bar2", h: {:foo => :bar, :foo2 => :bar2}}

    ]

    prods.each do |item|
      p p.parse_with_debug(item[:s])
      # p p.parse(item[:s])
    end

  end

  describe HashTransform do

    it 'should parse and transform a basic value hash' do
      p = HashParse.new
      t = HashTransform.new

      prods = [
          {s: "{ :foo => 123 }", h: {:foo => 123}},
          {s: "{ :foo => :bar }", h: {:foo => :bar}},
          {s: "{ 123 => 456 }", h: {123 => 456}},
          {s: "{ foo: 456 }", h: {:foo => 456}},
          {s: "{ foo: :bar }", h: {:foo => :bar}},
          {s: "{ foo: '123' }", h: {:foo => '123'}},
          {s: "{ foo: /foo/ }", h: {:foo => /foo/}},
          {s: "{ foo: true }", h: {:foo => true}},
          {s: "{ :foo => :bar, :foo2 => :bar2}", h: {:foo => :bar, :foo2 => :bar2}},
          {s: ":foo => :bar, :foo2 => :bar2", h: {:foo => :bar, :foo2 => :bar2}}

      ]

      prods.each do |item|
        s = item[:s]
        h = t.apply(p.parse(s))
        h.should eq(item[:h])
        puts "#{s} => #{h}"

      end

    end
  end


  describe "String to Hash" do

    it 'should Convert a string to corresponding hash' do

      prods = [
          {s: "{ :foo => 123 }", h: {:foo => 123}},
          {s: "{ :foo => :bar }", h: {:foo => :bar}},
          {s: "{ 123 => 456 }", h: {123 => 456}},
          {s: "{ foo: 456 }", h: {:foo => 456}},
          {s: "{ foo: :bar }", h: {:foo => :bar}},
          {s: "{ foo: '123' }", h: {:foo => '123'}},
          {s: "{ foo: /foo/ }", h: {:foo => /foo/}},
          {s: "  { foo: true }    ", h: {:foo => true}},
          {s: "{ :foo => :bar, :foo2 => :bar2}", h: {:foo => :bar, :foo2 => :bar2}},
          {s: ":foo => :bar, :foo2 => :bar2", h: {:foo => :bar, :foo2 => :bar2}}

      ]

      prods.each do |item|
        s = item[:s]
        h = s.to_h
        h.should eq(item[:h])
        puts "\"#{s}\" => #{h}"

      end

    end
  end

end
