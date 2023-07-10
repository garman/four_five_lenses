require 'debug'
require_relative 'parse_lens_list'

class FourByFiveLensChecker
  class KeyError < StandardError; end

  def initialize(lenses = nil, &block)
    @lenses = if lenses.nil? && block_given?
                yield self
              else
                lenses
              end
  end

  def filter(**opts)
    invalid_filters = check_filters(**opts)
    if invalid_filters.any?
      raise KeyError.new("#{invalid_filters.keys.join(", ")} not allowed, use one of #{keys}")
    end

    lenses.select! do |lens|
      opts.all? { |k, _| lens[k] == opts[k] }
    end
    self
  end

  def sort(*opts)
    lenses.sort_by! { |lens| opts.map { |opt| lens[opt] } }
    self
  end

  def pluck(*keys)
    lenses.map do |x|
      keys.map do |key|
        x[key]
      end
    end
  end

  private

  attr_accessor :lenses, :keys

  def check_filters(opts)
    opts.select { |opt| !keys.include?(opt) }
  end

  def keys
    @_keys ||= lenses.first.keys
  end
end
