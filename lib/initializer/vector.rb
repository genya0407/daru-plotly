require 'rbplotly'
require 'daru'

module Daru::Plotly
  module Initializer
    module Vector
      def self.plot(vector, opts={})
        raise ArgumentError, "first argument should be Daru::Vector, not #{vector.class}." unless vector.is_a?(Daru::Vector)
        data = generate_data(vector, opts)
        layout = { width: (opts[:width] || 1000), height: (opts[:height] || 500) }.merge(opts[:layout] || {})

        plot = Plotly::Plot.new(data: data, layout: layout)
        yield plot if block_given?
        plot
      end

      def self.extract_type(plot_type)
        supported_types = [:scatter, :bar, :histogram, :pie]

        case plot_type
        when *supported_types
          plot_type
        when nil
          :scatter
        else
          raise ArgumentError, "Type must be included in #{supported_types}."
        end
      end

      def self.generate_data(vector, opts)
        type = extract_type opts[:type]
        
        case type
        when :histogram
          [{ x: vector.to_a, type: :histogram }.merge(opts[:opts] || {})]
        when :scatter, :bar
          [{ x: vector.index.to_a, y: vector.to_a, type: type, mode: (opts[:mode]&.join('+')&.to_sym || :markers) }.merge(opts[:opts] || {})]
        when :pie
          [{ labels: vector.index.to_a, values: vector.to_a, type: :pie }.merge(opts[:opts] || {})]
        end
      end
    end
  end
end
