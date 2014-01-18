require 'spec_helper'

describe 'Post' do
  before do
    @piece = Piece.new(accession_number: '2002.10-PS-20')
    @piece.save!
    @post = Post.new({accession_number: '2002.10-PS-20', name: 'Test User', comment: 'Beautiful painting', piece_id: @piece.id})
  end

  subject { @post }

  it { should respond_to :accession_number }
  it { should respond_to :name }
  it { should respond_to :comment }
  its(:piece_id) { should eql @piece.id }

  it { should be_valid }

  describe "when piece_id not present" do
    before { @post.piece_id = nil }

    it { should_not be_valid }
  end

  describe "with empty name" do
    before { @post.name = nil }

    it { should_not be_valid }
  end

  describe "with empty comment" do
    before { @post.comment = nil }

    it { should_not be_valid }
  end

  describe "with long comment" do
    before { @post.comment = "a" * 141 }

    it { should_not be_valid }
  end
  
end
