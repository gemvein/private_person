require 'spec_helper'

describe Page do
  it { should have_many(:permissions) }
  it { should have_many(:permissors).through(:permissions) }
  it { should belong_to(:user) }
end
