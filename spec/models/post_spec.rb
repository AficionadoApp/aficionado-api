require 'spec_helper'

describe 'Post' do
  it { should have_many :pieces }

  it { should respond_to :piece_id }
  
end
