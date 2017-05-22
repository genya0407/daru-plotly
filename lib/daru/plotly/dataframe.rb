require 'rbplotly'
require 'daru'

module Daru
  module Plotly
    # exports #plot and #generate_data for DataFrame
    module DataFrame
      class << self
        include Daru::Plotly

        def generate_data(df, opts)
          case extract_type(opts[:type])
          when :pie
            generate_data_for_pie(df, opts)
          when :heatmap
            generate_data_for_heatmap(df, opts)
          else
            generate_data_for_scatter_and_bar(df, opts)
          end.map { |trace| trace.merge(opts[:opts] || {}) }
        end

        def generate_data_for_pie(df, opts)
          labels = df[opts[:labels] || :labels].to_a
          values = df[opts[:values] || :values].to_a
          [
            {
              labels: labels,
              values: values,
              type: :pie
            }
          ]
        end

        def generate_data_for_heatmap(df, _opts)
          [
            {
              z: df.data.map(&:to_a).transpose,
              x: df.vectors.to_a,
              y: df.index.to_a,
              type: :heatmap
            }
          ]
        end

        def generate_data_for_scatter_and_bar(df, opts)
          x = df[opts[:x] || :x].to_a
          mode = extract_mode_string(opts[:mode])
          Array(opts[:y] || :y).map do |vector_name|
            {
              x: x, y: df[vector_name].to_a,
              type: opts[:type],
              mode: mode,
              name: vector_name
            }
          end
        end

        def supported_types
          %i[scatter bar pie heatmap]
        end
      end
    end
  end
end
