module Daru
  class DataFrame
    def plotting_library= lib
      if lib == :plotly
        @plotting_library = lib
        extend Module.const_get(
          "Daru::Plotting::DataFrame::#{lib.to_s.capitalize}Library"
        )
      else
        super lib
      end
    end
  end
end
