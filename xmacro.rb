def e(txt); puts txt; end
def key(t, c)
  c = c.to_s
  # keys requiring SHIFT
  shift = (c.length == 1 and c.match(/[A-Z~!@#$\%^&*()_+|{}:"<>?]/))
  # aliases
  map = <<-MAP
  Enter Return
  Space space
  Ctrl  Control_L
  Alt   Alt_L
  Shift Shift_L
  Mod   Super_L
  Super Super_L
  Esc   Escape
        space
  ' "   apostrophe
  - _   minus
  ` ~   grave
  1 !   1
  2 @   2
  3 #   3
  4 $   4
  5 %   5
  6 ^   6
  7 &   7
  8 *   8
  9 (   9
  0 )   0
  - _   minus
  = +   equal
  \\ |  backslash
  [ {   bracketleft
  ] }   bracketright
  ; :   semicolon
  ' "   apostrophe
  , <   comma
  . >   period
  / ?   slash
  MAP
  map.split("\n").each do |line|
    matches = line[4...5] == ' ' ?
      [line[3...4], line[5...6], line[7..-1].strip] :
      line[2..-1].strip.split(/\s+/)
    after = matches.pop
    if matches.include?(c)
      c = after
      break
    end
  end
  c = c.downcase if shift

  keydown :Shift if shift and t == :Press
  e "KeyStr#{t} #{c}\n"
  keyup :Shift if shift and t == :Press
end
def keyup(c) key :Release, c; end
def keydown(c) key :Press, c; end
def keypress(*keys)
  keys.each do |c| keydown c; end
  keys.reverse.each do |c| keyup c; end
#   wait 0.1
  wait 1 if $debug # wait a full second between each keypress if debugging is enabled
end
def type(txt) txt.to_s.split('').each do |c| keypress c; end; end
def enter(txt=nil); type txt if txt; keypress :Enter; wait; end
def move(x, y) e "MotionNotify #{x} #{y}"; end
def press(btn=1) e "ButtonPress #{btn}"; end
def release(btn=1) e "ButtonRelease #{btn}"; end
def click(btn=1) press btn; release btn; end
def moveAndClick(x, y, btn=1) move(x, y); click(btn); end
def moveAndClickPercentage(xp, yp, btn=1)
  x, y = `xrandr`.scan(/current (\d+) x (\d+)/).flatten # linux only
  move (x.to_i * xp).ceil, (y.to_i * yp).ceil
  click btn
end
def wait(sec=1) e "Delay #{(sec*1000000).to_i}\n\n"; end
def debug(bool) $debug = bool; end

if ARGV.count > 0
  require ARGV[0]
end
