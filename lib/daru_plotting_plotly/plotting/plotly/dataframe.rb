require 'rbplotly'

module Daru
  module Plotting
    module DataFrame
      module PlotlyLibrary
        include ::Plotly

        def plot opts={}
          type = opts[:type] || :scatter
          layout = { width: (opts[:width] || 500), height: (opts[:height] || 500) }
          mode = opts[:mode] || :'lines+markers'

          x = self[opts[:x] || :x].to_a
          ys = if !opts[:y].nil?
                 ys_before_format = self[*Array(opts[:y])]
                 if ys_before_format.is_a?(Daru::DataFrame)
                   ys_before_format.to_a
                 else # when Daru::Vector
                   [ys_before_format.to_a]
                 end
               else
                 [self[:y].to_a]
               end
          data = ys.map { |y| { x: x, y: y, type: type, mode: mode } }
          plot = Plot.new(data: data, layout: layout)
          plot.show
          yield plot if block_given?
          plot
        end
      end
    end
  end
end
