require 'parslet'

# @author karl l <karl@ninjacontrol.com>
class HashParse < Parslet::Parser

  rule(:lcbracket) { str('{') >> sp? }
  rule(:rcbracket) { str('}') >> sp? }
  rule(:lbracket) { str('[') >> sp? }
  rule(:rbracket) { str(']') >> sp? }
  rule(:lparen) { str('(') >> sp? }
  rule(:rparen) { str(')') >> sp? }
  rule(:comma) { str(',') >> sp? }
  rule(:larrow) { str('=>') >> sp? }

  rule(:sp) { match('\s').repeat(1) }
  rule(:sp?) { sp.maybe }

  # values
  
  rule(:hex_integer) { 
    ( str('-').maybe >> (str('0x')|str('0X')) >> match['0-9a-fA-F'].repeat(1) ).as(:hex_int) >> sp? 
  }
  
  rule(:dec_integer) { 
    ( str('-').maybe >> match['0-9'].repeat(1) ).as(:dec_int) >> sp? 
  }
  
  rule(:bin_integer) { 
    ( str('-').maybe >> (str('0b') | str('0B')) >> (str('1')|str('0')).repeat(1) ).as(:bin_int) >> sp? 
  }
  
  rule(:dec_float) { 
    ( str('-').maybe >> match['0-9'].repeat(1) >> str('.') >> match['0-9'].repeat(1) ).as(:dec_f) >> sp? 
  }

  rule(:string) { 
      ( 
        (str("'") >> match["^'"].repeat(1).as(:str) >> str("'")) |
        (str('"') >> match['^"'].repeat(1).as(:str) >> str('"'))
      ) >> sp?
  }
  
  rule(:pattern) { 
    str("/") >> match['^/'].repeat(1).as(:pat) >> str("/") >> sp? 
  }
  
  rule(:symbol) { 
    str(":") >> ( match['a-zA-Z_'] >> match['a-zA-Z0-9_'].repeat ).as(:sym) >> sp? 
  }
  rule(:h_symbol) { 
    ( match['a-zA-Z_'] >> match['a-zA-Z0-9_'].repeat ).as(:sym) >> str(':') >> sp? 
  }
  
  rule(:boolean) { 
    ( str('true') | str('false') ).as(:boolean) >> sp? 
  }

  rule(:value) { 

    hex_integer | 
    dec_float |
    bin_integer |
    dec_integer | 
    string |
    pattern |
    symbol |
    boolean 

  }

  # hashes

  rule(:key_value) { 
    ( value.as(:key) >> larrow | h_symbol.as(:key) ) >> value.as(:val) 
  }
  
  rule(:key_value_lst) { 
    key_value >> (comma >> key_value).repeat 
  }
  
  rule(:simple_hash) { 
    ( lcbracket >> key_value_lst >> rcbracket | key_value_lst ).as(:hash) 
  }

  root :simple_hash

end

# @author karl l <karl@ninjacontrol.com>
class HashTransform < Parslet::Transform

  rule(:dec_int => simple(:i)) { Integer(i) }

  rule(:hex_int => simple(:i)) { Integer(i) }

  rule(:bin_int => simple(:i)) { Integer(i) }

  rule(:str => simple(:s)) { s.to_s }

  rule(:pat => simple(:p)) { /#{p}/ }

  rule(:sym => simple(:symb)) { symb.to_sym }

  rule(:dec_f => simple(:f)) { Float(f) }

  rule(:boolean => simple(:b)) {
    case b
      when "true"
        true
      when "false"
        false
    end
  }

  rule(:hash => subtree(:h)) {
    (h.is_a?(Array) ? h : [ h ]).inject({}) { |h, e| h[e[:key]] = e[:val] ;h }
  }

end


# Defines String#to_h
# @author karl l <karl@ninjacontrol.com>
module Str2Hash

  # @deprecated
  def str_to_hash(str)

  end

  module String

    #
    # Converts the string to a hash representation
    # @return [Hash] Hash representation of the string
    # @raise [Parslet::ParseFailed] If parsing of the string fails
    #
    # @example
    #  "{ :foo => 'bar'}".to_h
    #  => {:foo=>"bar"}
    #
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
