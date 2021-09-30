class Table

  class Align

    attr_reader :block

    def initialize(&block)
      @block = block
    end

    def call(text, width)
      block.call text, width
    end

  end

  LEFT = Align.new { |text, width| text.ljust(width) }
  RIGHT = Align.new { |text, width| text.rjust(width) }
  CENTER = Align.new { |text, width| text.center(width) }

  class Format

    attr_reader :sprintf_format
    attr_reader :default_align
    attr_reader :block

    def initialize(sprintf_format = "%s", align: LEFT, &block)
      @sprintf_format = sprintf_format
      @default_align = align
      @block = block
    end

    def call(value)
      block ? block.call(value) : (sprintf_format % value)
    end

    def to_s
      "#{sprintf_format} #{block}"
    end

  end

  STRING = Format.new
  INT = Format.new "%d", align: RIGHT
  FLOAT0 = Format.new "%0.0f", align: RIGHT
  FLOAT1 = Format.new "%0.1f", align: RIGHT
  FLOAT2 = Format.new "%0.2f", align: RIGHT
  US_CURRENCY = Format.new("$%0.2f", align: RIGHT)
  PERCENT0 = Format.new(align: RIGHT) { |value| "%0.0f%%" % (value * 100.0) }
  PERCENT1 = Format.new(align: RIGHT) { |value| "%0.1f%%" % (value * 100.0) }
  PERCENT2 = Format.new(align: RIGHT) { |value| "%0.2f%%" % (value * 100.0) }

  def initialize(between: " | ")
    @widths = []
    @rows = []
    @column_count = 0
    @between = between
    @formats = []
    @aligns = []
    @all_headers = []
    @header_aligns = []
  end

  def stringify_and_measure(fields, formats, default_format = STRING)
    ans = []
    @column_count = fields.count if fields.count > @column_count
    fields.each_with_index do |field, index|
      format = formats[index] || default_format
      begin
        s = format.call(field)
      rescue
        puts "processing column ##{index + 1}"
        raise
      end
      ans << s
      current_width = @widths[index] ? @widths[index] : 0
      @widths[index] = s.length if s.length > current_width
    end
    ans
  end

  private def header_split(name_or_array)
    puts name_or_array_klass: name_or_array.class
    if name_or_array.is_a? Array
      (name, arg1, arg2) = name_or_array
      if (arg1.is_a? Format)
        format = arg1
        align = arg2
      elsif (arg1.is_a? Align)
        format = STRING
        align = arg1
      end
      format = format || STRING
      align = align || format.default_align
      puts name: name, format: format, align: align
      [name.split("\n"), format, align]
    else
      [name_or_array.to_s.split("\n"), STRING, LEFT]
    end
  end

  def headers=(headers)
    puts headers: headers
    headers = Array(headers)
    all_names = []
    @formats = Array.new(headers.length, STRING)
    @aligns = Array.new(headers.length, LEFT)
    headers.each_with_index do |header, column|
      names, format, align = header_split(header)
      names.reverse.each_with_index do |name, row|
        all_names[row] = Array.new(headers.length, "") unless all_names[row]
        all_names[row][column] = name
      end
      @formats[column] = format
      @aligns[column] = align
    end
    all_names = all_names.reverse
    @all_headers = all_names.collect do |names|
      stringify_and_measure names, []
    end
  end

  # def aligns=(aligns)
  #   @aligns = Array(aligns).dup
  # end

  def header_aligns=(aligns)
    @header_aligns = Array(aligns).dup
  end

  # def formats=(formats)
  #   @formats = Array(formats).dup
  # end

  def add(*fields)
    @rows << stringify_and_measure(Array(fields), @formats)
  end

  def total_width
    @widths.compact.sum + (@widths.length - 1) * @between.length
  end

  def render_row(aligns, fields, default_align = LEFT)
    s = Array(@column_count)
    for index in 0...@column_count
      align = aligns[index] || default_align
      field = fields[index] || ""
      width = @widths[index] || 0
      s[index] = align.call(field, width)
    end
    s.join @between
  end

  def render(before: "")
    if @all_headers && @all_headers.length > 0
      @all_headers.each do |headers|
        puts "#{before}#{render_row(@header_aligns, headers, CENTER)}"
      end
      puts "#{before}#{'=' * total_width}"
    end
    @rows.each do |row|
      puts "#{before}#{render_row(@aligns, row)}"
    end
  end

end
