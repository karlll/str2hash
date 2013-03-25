str2hash
========

Tiny parser for converting strings to hashes (without using eval).

# Usage 

str2hash adds String#to_h 

    "{ :foo => 123 }".to_h => {:foo=>123}
    "{ :foo => :bar }".to_h => {:foo=>:bar}
    "{ 123 => 456 }".to_h => {123=>456}
    "{ foo: 456 }".to_h => {:foo=>456}
    "{ foo: :bar }".to_h => {:foo=>:bar}
    "{ foo: '123' }".to_h => {:foo=>"123"}
    "{ foo: /foo/ }".to_h => {:foo=>/foo/}
    "  { foo: true }    ".to_h => {:foo=>true}
    "{ :foo => :bar, :foo2 => :bar2}".to_h => {:foo=>:bar, :foo2=>:bar2}
    ":foo => :bar, :foo2 => :bar2".to_h => {:foo=>:bar, :foo2=>:bar2}

# Limitations

No nested hashes, no arrays (yet). No bindings, only values.


# Version information

* 0.0.1 - Initial version

# Author

karlll <karl@ninjacontrol.com>, 2013
