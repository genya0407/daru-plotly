require 'rbplotly'

module Daru
  module Plotting
    module DataFrame
      module PlotlyLibrary
        def plot opts={}
          type = opts[:type] || :scatter
          layout = { width: (opts[:width] || 500), height: (opts[:height] || 500) }
          mode = opts[:mode] || :'lines+markers'

          x = self[opts[:x] || :x].to_a
          ys = if !opts[:y].nil?
                 Array(self[opts[:y]])
               else
                 [self[:y].to_a]
               end
          data = ys.map { |y| { x: x, y: y, type: type, mode: mode } }

          plot = Plotly::Plot.new(data: data, layout: layout)
          plot.show
          yield plot if block_given?
          plot
        end
      end
    end
  end
end
