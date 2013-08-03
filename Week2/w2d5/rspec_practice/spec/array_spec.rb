require 'rspec'
require 'array.rb'
require 'stock_picker.rb'

describe 'Array#my_uniq' do

  let(:array) { ["x", "y", "x"] }

  it "removes a single duplicate element" do
    [1, 2, 3, 2].my_uniq.should == [1, 2, 3]
  end
  it "removes multiple duplicate elements" do
    ["a", "a", "b", "a", "b", "c"].my_uniq.should == ["a", "b", "c"]
  end
  it "returns elements in the order that the first appeared" do
    ["x", "y", "z"].my_uniq.should == ["x", "y", "z"]
  end
  it "returns the modified array object (same object)" do
    array.object_id.should == array.my_uniq.object_id
  end
end


describe "Array#two_sum" do
  it "returns an empty array if we pass an empty array" do
    [].two_sum.should be_empty
  end
  it "returns an empty array if there are no pairs that sum to zero" do
    [1, 2, 3, 4, 5].two_sum.should == []
  end
  it "correctly identifies zero sum pairs" do
    [-1, 1].two_sum.should == [[0, 1]]
  end
  it "returns the pairs in sorted order" do
     [-1, 2, 1, -2, -3, 3].two_sum.should == [[0, 2], [1, 3], [4, 5]]
  end
  it "does not pair a unique 0 with itself" do
    [0, 4].two_sum.should == []
  end
  it "creates pairs of non-unique 0s" do
    [0, 4, 0].two_sum.should == [[0, 2]]
  end
end

describe "#my_transpose" do

  let (:matrix){ [[0, 1, 2], [3, 4, 5], [6, 7, 8] ]}
  let (:transposition){ [[0, 3, 6], [1, 4, 7], [2, 5, 8]] }
  let (:misshapen){ [[0, 1, 2], [3, 4, 5], [6, 7] ]}

  it "returns a transposition of a matrix" do
    matrix.my_transpose.should == transposition
  end

  it "raises an error if you give it misshapen matrices" do
    expect  { misshapen.my_transpose }.to raise_error(NotAMatrixError)
  end

  it "does not change the original array object" do
    matrix.my_transpose.object_id.should_not == matrix.object_id
  end

end

describe "#stock_picker" do

  it "tells you the most profitable pair of days for buying/selling" do
    [ 1, 2, 0, 6].stock_picker.should == [2, 3]
  end

  it "can deal with horrible weeks" do
    [ 6, 4, 3].stock_picker.should == [1, 2]
  end

  it "raises an error if you don't give it at least twp days" do
    expect { [1].stock_picker }.to raise_error(ArgumentError)
  end

  it "returns the first pair of days in case of a tie" do
    [1, 3, 1, 2, 1, 3 ].stock_picker.should == [0,1]
  end

end


