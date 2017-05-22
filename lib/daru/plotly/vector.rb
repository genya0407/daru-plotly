require 'rbplotly'
require 'daru'

module Daru
  module Plotly
    # exports #plot and #generate_data for Vector
    module Vector
      class << self
        include Daru::Plotly

        def generate_data(vector, opts)
          type = extract_type opts[:type]

          case type
          when :histogram
            generate_data_for_histogram(vector, opts)
          when :scatter, :bar
            generate_data_for_scatter_and_bar(vector, opts)
          when :pie
            generate_data_for_pie(vector, opts)
          end.map { |trace| trace.merge(opts[:opts] || {}) }
        end

        def generate_data_for_histogram(vector, _opts)
          [{ x: vector.to_a, type: :histogram }]
        end

        def generate_data_for_scatter_and_bar(vector, opts)
          [
            {
              x: vector.index.to_a, y: vector.to_a,
              type: opts[:type], mode: extract_mode_string(opts[:model])
            }
          ]
        end

        def generate_data_for_pie(vector, _opts)
          [{ labels: vector.index.to_a, values: vector.to_a, type: :pie }]
        end

        def supported_types
          %i[scatter bar histogram pie]
        end
      end
    end
  end
end
