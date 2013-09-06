require 'spec_helper'

describe Page do
  it { should have_many(:permissions) }
end
