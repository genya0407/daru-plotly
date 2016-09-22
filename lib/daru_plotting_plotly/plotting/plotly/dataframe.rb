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
      end
    end
  end
end
