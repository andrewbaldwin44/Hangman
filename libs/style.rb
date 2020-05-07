class String
  def red_highlight;      "\e[1;31;40m#{self}\e[0m" end
  def green_highlight;    "\e[1;32;40m#{self}\e[0m" end
  def blue_highlight;     "\e[1;34;40m#{self}\e[0m" end
  def yellow_highlight;   "\e[1;33;40m#{self}\e[0m" end

  def italic;         "\e[3m#{self}\e[23m" end
end
