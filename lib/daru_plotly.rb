require 'initializer/category'
require 'initializer/dataframe'
require 'initializer/vector'
require 'daru'

module Daru::Plotly::Initializer
  [:plot, :generate_data].each do |method_name|
    define_method method_name do |data, opts|
      if data.is_a? Daru::DataFrame
        Daru::Plotly::Initializer::DataFrame.send(method_name ,data, opts)
      elsif data.is_a? Daru::Vector
        Daru::Plotly::Initializer::Vector.send(method_name, data, opts)
      else
        raise ArgumentError, 'first argument should be Daru::DataFrame or Daru::Vector.'
      end
    end
  end

  module_function :plot, :generate_data
end
