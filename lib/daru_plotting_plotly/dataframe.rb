module PlottingLibraryPlotly
  def plotting_library= lib
    case lib
    when :gruff, :nyaplot, :plotly
      @plotting_library = lib
      extend Module.const_get(
        "Daru::Plotting::DataFrame::#{lib.to_s.capitalize}Library"
      )
    else
			raise ArgumentError, "Plotting library #{lib} not supported. "\
				'Supported libraries are :nyaplot and :gruff and :plotly'
		end
  end
end

module Daru
  class DataFrame
    prepend PlottingLibraryPlotly
  end
end
