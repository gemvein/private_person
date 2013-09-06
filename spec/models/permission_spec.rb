require 'spec_helper'

describe Permission do
  it { should belong_to(:permissor) }
  it { should belong_to(:permissible) }
end
