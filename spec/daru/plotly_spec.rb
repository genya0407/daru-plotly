require 'spec_helper'

describe Daru::Plotly do
  let(:xs)        { (:a..:i).to_a }
  let(:ys)        { (1..9).to_a }
  let(:data)      { { x: xs, y: ys } }
  let(:df)        { Daru::DataFrame.new(a: xs, b: ys) }
  let(:df_opts)   { { x: :a, y: :b } }
  let(:vect)      { Daru::Vector.new(ys, index: xs) }
  let(:vect_opts) { { type: :bar } }

  describe 'specific initializers' do
    it 'DataFrame' do
      d = Daru::Plotly::DataFrame.plot(df, df_opts).data[0]
      expect(x: d.x, y: d.y).to eq data
    end

    it 'Vector' do
      d = Daru::Plotly::Vector.plot(vect, vect_opts).data[0]
      expect(x: d.x, y: d.y).to eq data
    end
  end

  describe 'infer argument\'s class' do
    it 'DataFrame' do
      d = Daru::Plotly.plot(df, df_opts).data[0]
      expect(x: d.x, y: d.y).to eq data
    end

    it 'Vector' do
      d = Daru::Plotly.plot(vect, vect_opts).data[0]
      expect(x: d.x, y: d.y).to eq data
    end
  end
end
