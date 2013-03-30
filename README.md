str2hash
========

Tiny parser for converting strings to hashes (without using eval).

## Usage 

str2hash adds String#to_h 

    require 'str2hash'

    "{ :foo => 123 }".to_h => {:foo=>123}
    "{ :foo => -123 }".to_h => {:foo=>-123}
    "{ :foo => :bar }".to_h => {:foo=>:bar}
    "{ :foo => 123.456 }".to_h => {:foo=>123.456}
    "{ :foo => -123.456 }".to_h => {:foo=>-123.456}
    "{ :foo => 0x0123 }".to_h => {:foo=>291}
    "{ :foo => -0x0123 }".to_h => {:foo=>-291}
    "{ :foo => 0b010010010100010101}".to_h => {:foo=>75029}
    "{ :foo => -0b010010010100010101}".to_h => {:foo=>-75029}
    "{ 123 => 456 }".to_h => {123=>456}
    "{ foo: 456 }".to_h => {:foo=>456}
    "{ foo: :bar }".to_h => {:foo=>:bar}
    "{ foo: '123' }".to_h => {:foo=>"123"}
    "{ foo: "123" }".to_h => {:foo=>"123"}
    "{ foo: /foo/ }".to_h => {:foo=>/foo/}
    "{ foo: true }".to_h => {:foo=>true}
    "{ :foo => :bar, :foo2 => :bar2}".to_h => {:foo=>:bar, :foo2=>:bar2}
    ":foo => :bar, :foo2 => :bar2".to_h => {:foo=>:bar, :foo2=>:bar2}

## Limitations

No nested hashes, no arrays (yet). No bindings, only values.


## Version information

* 0.1.0 - Gem setup, Documentation
* 0.0.2 - Minor fixes
* 0.0.1 - Initial version


## License

MIT License:

    Copyright (c) 2013 karl l, <karl@ninjacontrol.com>

    Permission is hereby granted, free of charge, to any person obtaining a copy 
    of this software and associated documentation files (the "Software"), to 
    deal in the Software without restriction, including without limitation the 
    rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
    sell copies of the Software, and to permit persons to whom the Software is 
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in 
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.

## Author

karl l (karl@ninjacontrol.com), 2013
