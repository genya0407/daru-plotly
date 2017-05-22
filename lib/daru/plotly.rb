require 'daru'
require 'daru/plotly/category'
require 'daru/plotly/dataframe'
require 'daru/plotly/vector'
require 'daru/plotly/methods'

module Daru
  # Common methods for DataFrame and Vector
  module Plotly
    def plot(source, opts = {})
      data = opts[:data] || generate_data(source, opts)
      layout = default_layout.merge(opts[:layout] || {})

      plot = ::Plotly::Plot.new(data: data, layout: layout)
      yield plot if block_given?
      plot
    end

    def default_layout
      {
        width: 1000,
        height: 500
      }
    end

    def extract_mode_string(modes)
      (Array(modes) || [:markers]).map(&:to_s).join('+')
    end

    def extract_type(plot_type)
      case plot_type
      when nil
        :scatter
      when *supported_types
        plot_type
      else
        raise ArgumentError, "Type must be included in #{supported_types}."
      end
    end

    module_function :default_layout, :extract_mode_string, :extract_type
  end
end
