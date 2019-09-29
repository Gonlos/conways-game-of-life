require 'game_of_life.rb'

RSpec.describe GameOfLife do
  subject { GameOfLife.get_generation(cells, generations) }

  let(:blinker) do
    [[[0,1,0],[0,1,0],[0,1,0]],
     [[0,0,0],[1,1,1],[0,0,0]]]
  end

  let(:glider) do
    [[[1,0,0],[0,1,1],[1,1,0]],
     [[0,1,0],[0,0,1],[1,1,1]],
     [[1,0,1],[0,1,1],[0,1,0]],
     [[0,0,1],[1,0,1],[0,1,1]]]
  end

  let(:cabify) do
    [[[0,1,1,1,0],[1,0,0,0,1],[1,0,0,0,0],[1,0,0,0,1],[0,1,0,1,0],[0,0,1,0,0]],
     [[0,0,0,1,0],[0,0,1,1,1],[0,1,0,1,1],[1,1,1,0,0],[0,1,1,0,0],[0,0,1,1,1],[0,0,0,1,0]],
     [[0,0,1,1,1],[0,0,0,0,0],[1,0,0,0,1],[1,0,0,0,0],[1,0,0,0,0],[0,1,0,0,1],[0,0,1,1,1]],
     [[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,0,1],[0,0,0,0,0,0],[1,1,1,0,0,0],[0,1,1,0,0,0],[0,0,1,1,0,1],[0,0,0,1,1,1],[0,0,0,0,1,0]],
     [[0,0,0,0,1,1],[0,0,0,0,0,0],[0,1,0,0,0,0],[1,0,1,0,0,0],[1,0,0,0,0,0],[0,1,0,0,0,1],[0,0,1,0,0,1],[0,0,0,1,1,1]],
     [[0,1,0,0,0,0,0],[1,0,0,0,0,0,0],[1,0,0,0,0,0,0],[0,1,0,0,0,0,0],[0,0,1,1,0,1,1],[0,0,0,1,1,1,0],[0,0,0,0,1,0,0]],
     [[1,1,0,0,0,0,0],[1,1,0,0,0,0,0],[0,1,1,0,0,0,0],[0,0,1,1,0,1,1],[0,0,1,0,0,0,1],[0,0,0,1,1,1,0]],
     [[1,1,0,0,0,0,0],[0,0,0,0,0,0,0],[1,0,0,1,0,0,0],[0,0,0,1,0,1,1],[0,0,1,0,0,0,1],[0,0,0,1,1,1,0],[0,0,0,0,1,0,0]],
     [[1,1,0,0,0,0,0],[0,0,0,0,1,0,0],[0,0,1,1,1,1,1],[0,0,1,0,0,0,1],[0,0,0,1,1,1,0],[0,0,0,1,1,1,0]]]
  end

  context 'blinker' do
    let(:cells) { blinker[0] }

    context do
      context "1th generation" do
        it { is_expected.to eq blinker[1] }
      end
    end
  end

  context 'glider' do
    let(:cells) { glider[0] }

    (1..3).each do |generation|

      context "#{generation}th generation" do
        let(:generations)  { generation }
        it { is_expected.to eq glider[generation] }
      end
    end
  end


  context 'cabify' do
    let(:cells) { cabify[0] }

    (1..8).each do |generation|

      context "#{generation}th generation" do
        let(:generations) { generation }

        it { is_expected.to eq cabify[generation] }
      end
    end
  end
end