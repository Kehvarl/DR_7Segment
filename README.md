# DR_7Segment
7 segment display class for DragonRubyGTK

Sample usage

## API
Creating a Multi-Digit display
SevenSegmentDisplay.new
    Expects a Hash {} with
    x: Lower-left Corner.  Default: 0
    y: Lower-left corner.  Default: 0
    w: Complete width of display.  Default: 256
    h: Height of display.  Default: 96
    digits:  Number of Digits. Default: 4
    bga: Alpha/Transparency of display background image.  Default: 255
    r: Red channel. Default 255
    g: Green chennel. Default 255
    b: Blue channel. Default 255

    ```ruby
        SevenSegmentDisplay.new({x:512, y:312, w:256, h:96, bga:128, digits:4})
    ```

SeventSegmentDisplay.set_value(str)
    Expects a string containing the numeric value to display.
    Discards any decimal point
    Recommend padding with 0s to the correct length
    ```ruby
        MyDisplay.set_value(args.state.value.to_s().rjust(4, '0'))
    ```

SeventSegmentDisplay.set_digit(digit_index, value)

SeventSegmentDisplay.set_color(r,g,b)

SeventSegmentDisplay.xor_color(r,g,b)

SeventSegmentDisplay.get_color()


