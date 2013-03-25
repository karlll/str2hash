require 'parslet'

# Tiny parser for converting strings to hashes
# karlll <karl@ninjacontrol.com>, 2013-03-23

class HashParse < Parslet::Parser

  rule(:lcbracket) { str('{') >> space? }
  rule(:rcbracket) { str('}') >> space? }
  rule(:lbracket) { str('[') >> space? }
  rule(:rbracket) { str(']') >> space? }
  rule(:lparen) { str('(') >> space? }
  rule(:rparen) { str(')') >> space? }
  rule(:comma) { str(',') >> space? }
  rule(:larrow) { str('=>') >> space? }

  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  # values
  rule(:dec_integer) { match('[0-9]').repeat(1).as(:dec_int) >> space? }
  rule(:hex_integer) { (str('0x') | str('0X')) >> match['0-9a-fA-F'].repeat(1).as(:hex_int) >> space? }
  rule(:bin_integer) { (str('0b') | str('0B')) >> (str('1')|str('0')).repeat(1).as(:bin_int) >> space? }
  rule(:string) { ((str("'") >> match["^'"].repeat(1).as(:str) >> str("'")) |
      (str('"') >> match['^"'].repeat(1).as(:str) >> str('"'))) >> space? }
  rule(:pattern) { str("/") >> match['^/'].repeat(1).as(:pattern) >> str("/") >> space? }
  rule(:symbol) { str(":") >> (match['a-zA-Z_'] >> match['a-zA-Z0-9_'].repeat).as(:symbol) >> space? }
  rule(:h_symbol) { (match['a-zA-Z_'] >> match['a-zA-Z0-9_'].repeat).as(:symbol) >> str(':') >> space? }
  rule(:dec_float) { (match['0-9'].repeat(1) >> str('.') >> match['0-9'].repeat(1)).as(:float) >> space? }
  rule(:boolean) { (str('true') | str('false')).as(:boolean) >> space? }

  rule(:value) { dec_integer | hex_integer | bin_integer | string | pattern | symbol | dec_float | boolean }

  # hashes

  rule(:key_value) { ((value.as(:key) >> larrow) | (h_symbol.as(:key))) >> value.as(:value) }
  rule(:key_value_lst) { key_value >> (comma >> key_value).repeat }
  rule(:simple_hash) { ((lcbracket >> key_value_lst >> rcbracket) | key_value_lst).as(:hash) }

  root :simple_hash

end

class HashTransform < Parslet::Transform

  rule(:dec_int => simple(:i)) { Integer(i) }
  rule(:hex_int => simple(:i)) { Integer(i) }
  rule(:bin_int => simple(:i)) { Integer(i) }
  rule(:str => simple(:s)) { s.to_s }
  rule(:pattern => simple(:p)) { /#{p}/ }
  rule(:symbol => simple(:sym)) { sym.to_sym }
  rule(:dec_float => simple(:f)) { Float(f) }
  rule(:boolean => simple(:b)) {
    case b
      when "true"
        true
      when "false"
        false
    end
  }
  rule(:hash => subtree(:h)) {
  (h.is_a?(Array) ? h : [ h ]).inject({}) { |h, e| h[e[:key]] = e[:value] ;h }
  }
end


module Str2Hash

  def str_to_hash(str)

  end

  module String
    def to_h

      p = HashParse.new
      t = HashTransform.new

      h_str = self.clone
      h_str.strip!
      t.apply(p.parse(self.strip))

    end
  end


end

::String.send :include, ::Str2Hash::String
