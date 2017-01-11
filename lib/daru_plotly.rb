require 'initializer/category'
require 'initializer/dataframe'
require 'initializer/vector'
require 'daru'

module Daru::Plotly::Initializer
  def self.plot(data, opts)
    if data.is_a? Daru::DataFrame
      Daru::Plotly::Initializer::DataFrame.plot(data, opts)
    elsif data.is_a? Daru::Vector
      Daru::Plotly::Initializer::Vector.plot(data, opts)
    else
      raise ArgumentError, 'first argument should be Daru::DataFrame or Daru::Vector.'
    end
  end
end
