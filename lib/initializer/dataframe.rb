require 'rbplotly'
require 'daru'

module Daru::Plotly
  module Initializer
    module DataFrame
      def self.plot(df, opts={})
        raise ArgumentError, "first argument should be Daru::DataFrame, not #{df.class}." unless df.is_a?(Daru::DataFrame)
        data = opts[:data] || generate_data(df, opts)
        layout = { width: (opts[:width] || 1000), height: (opts[:height] || 500) }.merge(opts[:layout] || {})

        plot = Plotly::Plot.new(data: data, layout: layout)
        yield plot if block_given?
        plot
      end

      def self.extract_type(plot_type)
        supported_types = [:scatter, :bar, :pie]

        case plot_type
        when *supported_types
          plot_type
        when nil
          :scatter
        else
          raise ArgumentError, "Type must be included in #{supported_types}"
        end
      end

      def self.generate_data(df, opts)
        case type = extract_type(opts[:type])
        when :pie
          labels = self[opts[:labels] || :labels].to_a
          values = self[opts[:values] || :values].to_a
          [{ labels: labels, values: values, type: :pie }.merge(opts[:opts] || {})]
        else
          x = df[opts[:x] || :x].to_a
          mode = (Array(opts[:mode]) || [:markers]).map(&:to_s).join('+')
          Array(opts[:y] || :y).map do |vector_name|
            vector = df[vector_name]
            {
              x: x, y: vector.to_a, type: type, mode: mode, name: vector_name
            }.merge(opts[:opts] || {})
          end
        end
      end
    end
  end
end
