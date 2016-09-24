require 'rbplotly'

module Daru
  module Plotting
    module DataFrame
      module PlotlyLibrary
        include ::Plotly

        def plot opts={}
          type = extract_type opts[:type]
          layout = { width: (opts[:width] || 500), height: (opts[:height] || 500) }
          mode = (Array(opts[:mode]) || [:lines, :markers]).map(&:to_s).join('+')

          x = self[opts[:x] || :x].to_a
          data = self[*Array(opts[:y] || :y)].to_df.map do |vector|
            {
              x: x, y: vector.to_a, type: type, mode: mode, name: vector.name
            }
          end

          plot = Plot.new(data: data, layout: layout)
          plot.show
          yield plot if block_given?
          plot
        end

        def extract_type plot_type
          case plot_type
          when :scatter, :bar
            plot_type
          when nil
            :scatter
          else
            raise ArgumentError, 'daru_plotting_plotly currently supports only :scatter and :bar as plot type.'
          end
        end
      end
    end
  end
end
