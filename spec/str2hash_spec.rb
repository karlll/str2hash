require 'rspec'
require 'str2hash'
require 'parslet/convenience'


PRODS = [
    {s: "{ :foo => 123 }", h: {:foo => 123}},
    {s: "{ :foo => -123 }", h: {:foo => -123}},
    {s: "{ :foo => :bar }", h: {:foo => :bar}},
    {s: "{ :foo => 123.456 }", h: {:foo => 123.456}},
    {s: "{ :foo => -123.456 }", h: {:foo => -123.456}},
    {s: "{ :foo => 0x0123 }", h: {:foo => 291}},
    {s: "{ :foo => 0X0123 }", h: {:foo => 291}},
    {s: "{ :foo => -0x0123 }", h: {:foo => -291}},
    {s: "{ :foo => -0X0123 }", h: {:foo => -291}},
    {s: "{ :foo => 0b010010010100010101}", h: {:foo => 75029}},
    {s: "{ :foo => 0B010010010100010101}", h: {:foo => 75029}},
    {s: "{ :foo => -0b010010010100010101}", h: {:foo => -75029}},
    {s: "{ :foo => -0B010010010100010101}", h: {:foo => -75029}},
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

describe HashParse do


  it 'should parse a basic value hash' do
    p = HashParse.new

    PRODS.each do |item|
      p.parse(item[:s])
    end

  end

end

describe HashTransform do

  it 'should parse and transform a basic value hash' do
    p = HashParse.new
    t = HashTransform.new

    PRODS.each do |item|

      s = item[:s]
      h = t.apply(p.parse(s))
      h.should eq(item[:h])

    end

  end
end


describe "String to Hash" do

  it 'should Convert a string to corresponding hash' do

    PRODS.each do |item|
      s = item[:s]
      h = s.to_h
      h.should eq(item[:h])

      puts "\"#{s}\".to_h => #{h}"

    end

  end
end


