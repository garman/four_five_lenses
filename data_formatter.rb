class DataFormatter
  def self.perform(**args)
    new(**args).perform
  end

  def initialize(args)
    @lines = args[:lines]
  end

  def perform
    headers = generate_headers
    lines
      .map { |line| headers.zip(line).to_h }
      .map { |hash| hash.transform_values { |v| format_value(v) } }
      .drop(3)
  end

  private

  attr_reader :lines

  def generate_headers
    lines[0]
      .zip(lines[1])
      .zip(lines[2])
      .map(&:flatten)
      .map { |v| v.join(" ").strip.gsub(/\s+/, " ") }
  end

  def format_value(value)
    return value unless value

    value = value.gsub(/\s+/, " ")
    if value.to_f.to_s == value
      value.to_f
    elsif value.to_i.to_s == value
      value.to_i
    elsif value[0] == "$"
      value[1..-1].gsub(/[,\.]/, "").to_i
    else
      value
    end
  end
end
