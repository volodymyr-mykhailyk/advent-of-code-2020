require 'spec_helper'
require 'navigation/hexagonal_grid'

describe Navigation::HexagonalGrid do
  let(:grid) { described_class.new(->(x, y) { "#{x},#{y}" }) }

  context 'infinite grid' do
    it 'creates node on demand' do
      x = rand(1000)
      y = rand(1000)
      expect(grid.node_at([x, y])).to eq("#{x},#{y}")
    end
  end

  describe 'Navigation::HexagonalGrid::Navigator' do
    let(:navigator) { described_class::Navigator.new(grid) }

    describe 'directions' do
      it 'returns start without directions' do
        expect(navigator.coordinates_via('')).to eq([0, 0])
      end

      it 'returns node at "e"' do
        expect(navigator.coordinates_via('e')).to eq([2, 0])
      end

      it 'returns node at "ne"' do
        expect(navigator.coordinates_via('ne')).to eq([1, -1])
      end

      it 'returns node at "se"' do
        expect(navigator.coordinates_via('se')).to eq([1, 1])
      end

      it 'returns node at "w"' do
        expect(navigator.coordinates_via('w')).to eq([-2, 0])
      end

      it 'returns node at "nw"' do
        expect(navigator.coordinates_via('nw')).to eq([-1, -1])
      end

      it 'returns node at "sw"' do
        expect(navigator.coordinates_via('sw')).to eq([-1, 1])
      end

      it 'can return to start in triangle' do
        expect(navigator.coordinates_via('nwswe')).to eq([0, 0])
        expect(navigator.coordinates_via('nesew')).to eq([0, 0])
        expect(navigator.coordinates_via('swenw')).to eq([0, 0])
        expect(navigator.coordinates_via('eswnw')).to eq([0, 0])
      end

      it 'can return to start in 5 moves' do
        expect(navigator.coordinates_via('nwwswee')).to eq([0, 0])
        expect(navigator.coordinates_via('seeneww')).to eq([0, 0])
      end
    end
  end

  context "sample" do
    let(:grid) { described_class.new(->(x, y) { false }) }
    let(:navigator) { described_class::Navigator.new(grid) }

    before do
      flip_node('sesenwnenenewseeswwswswwnenewsewsw')
      flip_node('neeenesenwnwwswnenewnwwsewnenwseswesw')
      flip_node('seswneswswsenwwnwse')
      flip_node('nwnwneseeswswnenewneswwnewseswneseene')
      flip_node('swweswneswnenwsewnwneneseenw')
      flip_node('eesenwseswswnenwswnwnwsewwnwsene')
      flip_node('sewnenenenesenwsewnenwwwse')
      flip_node('wenwwweseeeweswwwnwwe')
      flip_node('wsweesenenewnwwnwsenewsenwwsesesenwne')
      flip_node('neeswseenwwswnwswswnw')
      flip_node('nenwswwsewswnenenewsenwsenwnesesenew')
      flip_node('enewnwewneswsewnwswenweswnenwsenwsw')
      flip_node('sweneswneswneneenwnewenewwneswswnese')
      flip_node('swwesenesewenwneswnwwneseswwne')
      flip_node('enesenwswwswneneswsenwnewswseenwsese')
      flip_node('wnwnesenesenenwwnenwsewesewsesesew')
      flip_node('nenewswnwewswnenesenwnesewesw')
      flip_node('eneswnwswnwsenenwnwnwwseeswneewsenese')
      flip_node('neswnwewnwnwseenwseesewsenwsweewe')
      flip_node('wseweeenwnesenwwwswnew')
    end

    it 'flips correct count of tiles' do
      expect(grid.nodes.count).to eq(15)
    end

    it 'flips correct count of black tiles' do
      expect(grid.nodes.count(&:itself)).to eq(10)
    end

    protected

    def flip_node(path)
      coordinates = navigator.coordinates_via(path)
      grid.update_at(coordinates, !grid.node_at(coordinates))
    end
  end
end