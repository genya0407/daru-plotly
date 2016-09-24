module DaruPlottingLibrary
  def plotting_library= lib
    case lib
    when :gruff, :nyaplot, :plotly
      @plotting_library = lib
    else
      raise ArgumentError, "Unsupported library #{lib}"
    end
  end
end

module PlottingLibrary
  def plotting_library= lib
    case lib
    when :gruff, :nyaplot, :plotly
      @plotting_library = lib
      extend Module.const_get(
        "Daru::Plotting::#{self.class.name.demodulize}::#{lib.to_s.capitalize}Library"
      )
    else
			raise ArgumentError, "Plotting library #{lib} not supported. "\
				'Supported libraries are :nyaplot and :gruff and :plotly'
		end
  end
end

module Daru
  class << self
    prepend DaruPlottingLibrary
  end

  class DataFrame
    prepend PlottingLibrary
  end

  class Vector
    prepend PlottingLibrary
  end
end
