require_relative 'data_formatter'
require_relative 'csv_reader'

class ParseLensList
  def self.perform(**args)
    args[:reader] = CsvReader unless args[:reader]
    args[:formatter] = DataFormatter unless args[:formatter]
    new(**args).perform
  end

  def initialize(args)
    @file      = args[:file]
    @reader    = args[:reader]
    @formatter = args[:formatter]
  end

  def perform
    lines = reader.perform(file: file)
    formatter.perform(lines: lines)
  end

  private

  attr_reader :file, :reader, :formatter
end

ParseLensList.perform(file: "45.csv")
