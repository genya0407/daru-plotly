require 'daru'

module Daru
  module Plotly
    # exports #plot and #generate_data for DataFrame and Vector
    module Methods
      %i[plot generate_data].each do |method_name|
        define_method method_name do |data, opts|
          if data.is_a? Daru::DataFrame
            Daru::Plotly::DataFrame.send(method_name, data, opts)
          elsif data.is_a? Daru::Vector
            Daru::Plotly::Vector.send(method_name, data, opts)
          else
            raise ArgumentError,
                  'first argument should be Daru::DataFrame or Daru::Vector.'
          end
        end
      end

      module_function :plot, :generate_data
    end
  end
end
