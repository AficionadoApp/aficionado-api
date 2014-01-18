require 'spec_helper'

describe PostsController do

  subject { @postcontroller }

  it { should respond_to :create }

end
