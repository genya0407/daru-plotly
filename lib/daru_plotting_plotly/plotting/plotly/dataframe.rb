require 'rbplotly'

module Daru
  module Plotting
    module DataFrame
      module PlotlyLibrary
        include ::Plotly

        def plot opts={}
          data = opts[:data] || generate_data opts
          layout = { width: (opts[:width] || 1000), height: (opts[:height] || 500) }

          plot = Plot.new(data: data, layout: layout)
          yield plot if block_given?
          plot.show
        end

        def extract_type plot_type
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

        def generate_data opts
          case type = extract_type(opts[:type])
          when :pie
            labels = self[opts[:labels] || :labels].to_a
            values = self[opts[:values] || :values].to_a
            [{ labels: labels, values: values, type: :pie }]
          else
            x = self[opts[:x] || :x].to_a
            ys = self[*Array(opts[:y] || :y)].to_df
            mode = (Array(opts[:mode]) || [:markers, :lines]).map(&:to_s).join('+')
            ys.map do |vector|
              {
                x: x, y: vector.to_a, type: type, mode: mode, name: vector.name
              }
            end
          end
        end
      end
    end
  end
end
