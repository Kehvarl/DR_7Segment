require 'app/7segment_display.rb'

def init args

  args.state.counter = SevenSegmentDisplay.new({x:512, y:312, w:256, h:96, bga:128, digits:4})
  # Color can be set during initial creation or after the fact
  args.state.counter.set_color(255, 196, 0)

  args.state.buttons = [
    {x:768, y:200, w:128, h:64, r:128, g:128, b:128, value:1},
    {x:608, y:200, w:128, h:64, r:128, g:128, b:128, value:10},
    {x:448, y:200, w:128, h:64, r:128, g:128, b:128, value:100}
  ]

  args.state.value = 0
  args.state.count_frames = 30
end

def render_buttons args
  out = []
  args.state.buttons.each do |b|
      out << b.solid!
      out << (b.merge({y: b.y + b.h - 16, x: b.x + 32, r:0, g:0, b:0, size_enum: b.h/8, text: b.value.to_s})).label!
  end
  out
end

def tick args
  if Kernel.tick_count <= 0
      init args
  end

  if args.inputs.mouse.click
    args.geometry.find_all_intersect_rect(args.inputs.mouse, args.state.buttons).each do |b|
      args.state.value += b.value
      args.state.counter.set_value(args.state.value.to_s().rjust(4, '0'))
    end
  end

  if Kernel.tick_count % args.state.count_frames == 0
    args.state.value += 1
    # The 7-segment display expects a STRING to work with.
    # The number of digits in your string should match the total number you've set the display to render
    args.state.counter.set_value(args.state.value.to_s().rjust(4, '0'))
  end

  args.outputs.primitives << {x:0, y:0, w:1280, h:720, r:0, g:0, b:0}.solid!
  # The "render" function returns an array that's ready to drop straight into your primitives.
  args.outputs.primitives << args.state.counter.render()

  args.outputs.primitives << render_buttons(args)
end
