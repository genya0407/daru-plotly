require 'rbplotly'

module Daru
  module Plotting
    module Vector
      module PlotlyLibrary
        include ::Plotly

        def plot opts={}
          data = generate_data opts
          layout = { width: (opts[:width] || 500), height: (opts[:height] || 500) }

          plot = Plot.new(data: data, layout: layout)
          yield plot if block_given?
          plot.show
        end

        def extract_type plot_type
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

        def generate_data opts
          type = extract_type opts[:type]
          
          case type
          when :histogram
            [{ x: to_a, type: :histogram}]
          when :scatter, :bar
            [{ x: index.to_a, y: to_a, type: type, mode: :'markers' }]
          when :pie
            [{ labels: index.to_a, values: to_a, type: :pie }]
          end
        end
      end
    end
  end
end
