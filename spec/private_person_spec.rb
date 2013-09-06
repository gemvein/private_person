require 'spec_helper'

describe PrivatePerson do
  it 'should return correct version string' do
    PrivatePerson.version_string.should == "PrivatePerson version #{PrivatePerson::VERSION}"
  end
end
