class CsvReader
  require 'csv'

  def self.perform(**args)
    args[:delimiter] = "|" unless args[:delimiter]
    new(**args).perform
  end

  def initialize(args)
    @file      = args[:file]
    @delimiter = args[:delimiter]
    @mode      = "r"
  end

  def perform
    CSV.open(file, mode, col_sep: delimiter) { |csv| csv.readlines }
  end

  private

  attr_reader :file, :mode, :delimiter
end
